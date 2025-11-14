#!/bin/bash

# Script to install Git hooks for CI/CD workflow notifications

echo "🔧 Installing Git hooks for CI/CD workflow notifications..."
echo ""

# Get the repository root
REPO_ROOT="$(git rev-parse --show-toplevel)"
HOOKS_DIR="$REPO_ROOT/.git/hooks"

if [ ! -d "$HOOKS_DIR" ]; then
    echo "❌ Error: .git/hooks directory not found"
    exit 1
fi

# Install pre-push hook
cat > "$HOOKS_DIR/pre-push" << 'HOOK_EOF'
#!/bin/bash

# Git pre-push hook to notify about CI/CD workflows
# This hook runs before pushing to remote and shows which workflows will be triggered

echo ""
echo "🚀 Preparing to push to GitHub..."
echo ""

# Get the remote and branch being pushed to
remote="$1"
url="$2"

# Get current branch
branch=$(git symbolic-ref --short HEAD 2>/dev/null)

if [ -z "$branch" ]; then
    exit 0
fi

echo "📦 Branch: $branch"
echo "🌐 Remote: $remote"
echo ""

# Check which workflows will be triggered based on branch and changed files
echo "✅ CI/CD Workflows that will be triggered:"
echo ""

# Check for backend changes
if git diff --name-only origin/$branch..HEAD 2>/dev/null | grep -q "^backend/"; then
    echo "  ✓ Backend CI (lint, test, build)"
fi

# Check for frontend changes
if git diff --name-only origin/$branch..HEAD 2>/dev/null | grep -qE "^(lib/|test/|pubspec.yaml)"; then
    echo "  ✓ Frontend CI (analyze, test, build)"
fi

# Check for workflow changes
if git diff --name-only origin/$branch..HEAD 2>/dev/null | grep -q "^.github/workflows/"; then
    echo "  ✓ Workflow validation"
fi

# Deployment workflows based on branch
if [ "$branch" = "main" ]; then
    echo "  ✓ Deploy Environments → Production"
    echo "  ✓ E2E Tests"
    echo "  ✓ Code Quality Checks"
elif [ "$branch" = "develop" ]; then
    echo "  ✓ Deploy Environments → Staging"
    echo "  ✓ E2E Tests"
fi

# Check for any changes (fallback)
if [ -z "$(git diff --name-only origin/$branch..HEAD 2>/dev/null)" ]; then
    echo "  ℹ️  No changes detected (workflows may not trigger)"
else
    echo ""
    echo "📋 Changed files:"
    git diff --name-only origin/$branch..HEAD 2>/dev/null | head -10 | sed 's/^/    - /'
    if [ $(git diff --name-only origin/$branch..HEAD 2>/dev/null | wc -l) -gt 10 ]; then
        echo "    ... and more"
    fi
fi

echo ""
echo "🔗 View workflows: https://github.com/Sportfiy-app/Sportify/actions"
echo ""
echo "Press Ctrl+C to cancel, or Enter to continue..."
read -t 3 -n 1 || true
echo ""
HOOK_EOF

# Install post-commit hook
cat > "$HOOKS_DIR/post-commit" << 'HOOK_EOF'
#!/bin/bash

# Git post-commit hook to remind about pushing and CI/CD
# This hook runs after each commit

echo ""
echo "✅ Commit created successfully!"
echo ""
echo "💡 Next steps:"
echo "   1. git push origin <branch>"
echo "   2. CI/CD workflows will automatically trigger on GitHub"
echo "   3. View progress: https://github.com/Sportfiy-app/Sportify/actions"
echo ""
HOOK_EOF

# Make hooks executable
chmod +x "$HOOKS_DIR/pre-push"
chmod +x "$HOOKS_DIR/post-commit"

echo "✅ Git hooks installed successfully!"
echo ""
echo "📋 Installed hooks:"
echo "  - pre-push: Shows CI/CD workflows before pushing"
echo "  - post-commit: Reminds to push after committing"
echo ""
echo "🚀 Next time you do 'git push', you'll see which workflows will be triggered!"

