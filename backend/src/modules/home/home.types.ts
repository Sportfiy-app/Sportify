export interface HomeFeedResponse {
  stories: HomeStory[];
  shortcuts: HomeShortcut[];
  posts: HomeFeedPost[];
  upcomingEvent: HomeEventHighlight;
  venue: HomeVenueHighlight;
  community: HomeCommunityHighlight;
}

export interface HomeStory {
  name?: string;
  imageUrl?: string;
  isAddButton?: boolean;
}

export interface HomeShortcut {
  label: string;
  icon: string;
  background: string;
  iconColor: string;
}

export interface HomeFeedPost {
  author: string;
  avatarUrl: string;
  location: string;
  distance: string;
  timeAgo: string;
  sportLabel: string;
  sportColor: string;
  message: string;
  imageUrl?: string | null;
  stats: HomeFeedStats;
  hasDirectMessageCta?: boolean;
}

export interface HomeFeedStats {
  likes: number;
  comments: number;
  shares: number;
  participants: number;
}

export interface HomeEventHighlight {
  id?: string;
  title: string;
  subtitle: string;
  organizer: string;
  badge: string;
  capacityLabel: string;
  priceLabel: string;
}

export interface HomeVenueHighlight {
  name: string;
  rating: string;
  distance: string;
  price: string;
  imageUrl: string;
}

export interface HomeCommunityHighlight {
  title: string;
  subtitle: string;
  headline: string;
  message: string;
  membersLabel: string;
  matchesLabel: string;
}
