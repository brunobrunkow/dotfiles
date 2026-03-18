.PHONY: install update backup clean help ssh

help:
	@echo "╔═══════════════════════════════════╗"
	@echo "║  📚 Dotfiles Management Help      ║"
	@echo "╚═══════════════════════════════════╝"
	@echo ""
	@echo "🚀 make install  - Run full installation"
	@echo "🔄 make update   - Update symlinks only"
	@echo "💾 make backup   - Backup existing configs"
	@echo "🔐 make ssh      - Setup SSH keys and config"
	@echo "🧹 make clean    - Remove symlinks"
	@echo "❓ make help     - Show this help"
	@echo ""

install:
	@echo "🚀 Starting full installation...\n"
	@sh bootstrap.sh

update:
	@echo "🔄 Updating symlinks..."
	@sh git/git.sh
	@sh zsh/zsh.sh
	@sh ghostty/ghostty.sh
	@sh hammerspoon/hammerspoon.sh
	@sh claude/claude.sh
	@echo "✅ Symlinks updated!\n"

backup:
	@echo "💾 Backing up existing configs..."
	@[ -f ~/.zshrc ] && cp ~/.zshrc ~/.zshrc.backup.$$(date +%Y%m%d_%H%M%S) && echo "  ✅ Backed up ~/.zshrc" || true
	@[ -f ~/.gitconfig ] && cp ~/.gitconfig ~/.gitconfig.backup.$$(date +%Y%m%d_%H%M%S) && echo "  ✅ Backed up ~/.gitconfig" || true
	@[ -f ~/.p10k.zsh ] && cp ~/.p10k.zsh ~/.p10k.zsh.backup.$$(date +%Y%m%d_%H%M%S) && echo "  ✅ Backed up ~/.p10k.zsh" || true
	@[ -f ~/.gitignore_global ] && cp ~/.gitignore_global ~/.gitignore_global.backup.$$(date +%Y%m%d_%H%M%S) && echo "  ✅ Backed up ~/.gitignore_global" || true
	@echo "✅ Backups created with timestamp!\n"

ssh:
	@echo "🔐 Setting up SSH..."
	@sh ssh/ssh.sh

clean:
	@echo "🧹 Removing symlinks..."
	@rm -f ~/.zshrc && echo "  ✅ Removed ~/.zshrc" || true
	@rm -f ~/.p10k.zsh && echo "  ✅ Removed ~/.p10k.zsh" || true
	@rm -f ~/.gitconfig && echo "  ✅ Removed ~/.gitconfig" || true
	@rm -f ~/.gitignore_global && echo "  ✅ Removed ~/.gitignore_global" || true
	@rm -rf ~/.hammerspoon && echo "  ✅ Removed ~/.hammerspoon" || true
	@rm -f ~/.claude/CLAUDE.md && echo "  ✅ Removed ~/.claude/CLAUDE.md" || true
	@rm -f ~/.claude/settings.json && echo "  ✅ Removed ~/.claude/settings.json" || true
	@echo "✅ All symlinks removed!\n"
