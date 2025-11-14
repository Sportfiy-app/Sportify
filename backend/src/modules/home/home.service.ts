import { PrismaClient } from '@prisma/client';

import { prisma } from '../../db/prisma';
import { PostsService } from '../posts/posts.service';
import { EventsService } from '../events/events.service';
import { HomeFeedResponse } from './home.types';

export class HomeService {
  private db: PrismaClient;
  private postsService: PostsService;
  private eventsService: EventsService;

  constructor() {
    this.db = prisma;
    this.postsService = new PostsService();
    this.eventsService = new EventsService();
  }

  async getHomeFeed(userId?: string): Promise<HomeFeedResponse> {
    // Get recent posts (limit 20)
    const postsResult = await this.postsService.getPosts(
      {
        limit: 20,
        offset: 0,
      },
      userId,
    );

    // Get upcoming events (limit 1 for highlight)
    const eventsResult = await this.eventsService.getEvents({
      status: 'UPCOMING' as any,
      limit: 1,
      offset: 0,
    });

    // Get recent users for stories (users who have created posts recently)
    const recentUsers = await this.db.user.findMany({
      where: {
        posts: {
          some: {
            createdAt: {
              gte: new Date(Date.now() - 7 * 24 * 60 * 60 * 1000), // Last 7 days
            },
          },
        },
      },
      select: {
        id: true,
        firstName: true,
        lastName: true,
        avatarUrl: true,
      },
      take: 5,
      distinct: ['id'],
    });

    // Format posts for home feed
    const formattedPosts = postsResult.posts.map((post) => {
      const authorName = post.authorFirstName && post.authorLastName
        ? `${post.authorFirstName} ${post.authorLastName}`
        : 'Utilisateur';
      
      const timeAgo = this.formatTimeAgo(post.createdAt);
      const distance = post.distance ? `${post.distance.toFixed(1)} km` : '';
      
      return {
        author: authorName,
        avatarUrl: post.authorAvatarUrl || '',
        location: post.location || 'Non spécifié',
        distance: distance,
        timeAgo: timeAgo,
        sportLabel: post.sport || 'Sport',
        sportColor: this.getSportColor(post.sport || ''),
        message: post.content,
        imageUrl: post.imageUrl,
        stats: {
          likes: post.likesCount,
          comments: post.commentsCount,
          shares: 0, // Not implemented yet
          participants: 0, // Could be from event if post is linked to event
        },
        hasDirectMessageCta: false,
      };
    });

    // Format upcoming event
    const upcomingEvent = eventsResult.events.length > 0
      ? (() => {
          const event = eventsResult.events[0];
          const organizer = event.organizer;
          const organizerName = organizer?.firstName && organizer?.lastName
            ? `${organizer.firstName} ${organizer.lastName}`
            : 'Organisateur';
          
          const eventDate = new Date(event.date);
          const dateStr = eventDate.toLocaleDateString('fr-FR', {
            weekday: 'long',
            day: 'numeric',
            month: 'long',
          });
          const timeStr = event.time;
          const subtitle = `${dateStr} • ${timeStr} • ${event.location}`;
          
          const priceLabel = event.price
            ? `${event.price}${event.priceCurrency || 'EUR'}`
            : 'Gratuit';
          
          // Calculate current participants from participations
          const currentParticipants = event.participations?.length || 0;
          
          return {
            id: event.id,
            title: event.title,
            subtitle: subtitle,
            organizer: organizerName,
            badge: event.difficultyLevel || 'STANDARD',
            capacityLabel: `${currentParticipants}/${event.maxParticipants} inscrits`,
            priceLabel: priceLabel,
          };
        })()
      : {
          title: 'Aucun événement à venir',
          subtitle: 'Créez votre premier événement !',
          organizer: 'Sportify',
          badge: '',
          capacityLabel: '',
          priceLabel: '',
        };

    // Format stories (users who posted recently)
    const stories = [
      { isAddButton: true },
      ...recentUsers.map((user) => ({
        name: user.firstName || 'Utilisateur',
        imageUrl: user.avatarUrl || '',
      })),
    ];

    // Keep shortcuts and other static data
    return {
      stories: stories,
      shortcuts: [
        {
          label: 'Créer événement',
          icon: 'event_available_outlined',
          background: '#19176BFF',
          iconColor: '#176BFF',
        },
        {
          label: 'Terrains proches',
          icon: 'location_on_outlined',
          background: '#1916A34A',
          iconColor: '#16A34A',
        },
        {
          label: 'Groupes',
          icon: 'groups_2_outlined',
          background: '#19FFB800',
          iconColor: '#FFB800',
        },
        {
          label: 'Tournois',
          icon: 'military_tech_outlined',
          background: '#190EA5E9',
          iconColor: '#0EA5E9',
        },
      ],
      posts: formattedPosts,
      upcomingEvent: upcomingEvent,
      venue: {
        name: 'Tennis Club Auteuil',
        rating: '4.8',
        distance: '900 m',
        price: 'Dès 25€/h',
        imageUrl: 'https://images.unsplash.com/photo-1505751104546-4b63c93054b1?auto=format&fit=crop&w=900&q=60',
      },
      community: {
        title: 'Communauté Sportify',
        subtitle: 'Actualité de la semaine',
        headline: '🎉 1000 matchs organisés ce mois !',
        message: 'La communauté Sportify grandit ! Merci à tous les sportifs actifs. Continuez à partager vos sessions !',
        membersLabel: '12.4k membres',
        matchesLabel: '1000 matchs',
      },
    };
  }

  private formatTimeAgo(date: Date): string {
    const now = new Date();
    const diffMs = now.getTime() - date.getTime();
    const diffMins = Math.floor(diffMs / 60000);
    const diffHours = Math.floor(diffMs / 3600000);
    const diffDays = Math.floor(diffMs / 86400000);

    if (diffMins < 1) return 'À l\'instant';
    if (diffMins < 60) return `il y a ${diffMins}min`;
    if (diffHours < 24) return `il y a ${diffHours}h`;
    if (diffDays < 7) return `il y a ${diffDays}j`;
    return date.toLocaleDateString('fr-FR');
  }

  private getSportColor(sport: string): string {
    const colors: Record<string, string> = {
      Football: '#176BFF',
      Tennis: '#16A34A',
      Basketball: '#FFB800',
      Running: '#16A34A',
      Fitness: '#0EA5E9',
      Yoga: '#8B5CF6',
      Natation: '#06B6D4',
      Cyclisme: '#16A34A',
      Volleyball: '#F59E0B',
      Badminton: '#EC4899',
    };
    return colors[sport] || '#176BFF';
  }
}
