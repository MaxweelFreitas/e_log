# =========================
# 🎨 Cores ANSI
# =========================
RESET  := \033[0m
BOLD   := \033[1m
RED    := \033[31m
GREEN  := \033[32m
YELLOW := \033[33m
BLUE   := \033[34m
CYAN   := \033[37m
GRAY   := \033[90m

# =========================
# 📁 Pastas e arquivos
# =========================
OUTPUT_DIR := tree-output
TREE_BASE  := tree
TIMESTAMP  := $(shell date +"%Y-%m-%d_%H-%M-%S")
TREE_OUTPUT := $(OUTPUT_DIR)/$(TREE_BASE)_$(TIMESTAMP).txt

# =========================
# 🚫 Padrões do .gitignore + fixos
# =========================
GITIGNORE_PATTERNS := $(shell \
	BASE_IGNORE=".git|.cursor"; \
	if [ -f .gitignore ]; then \
		GIT_IGNORE=$$(grep -v '^\s*#' .gitignore | \
			grep -v '^\s*$$' | \
			sed 's|/$$||' | \
			sed 's|\.|\\.|g' | \
			tr '\n' '|' | \
			sed 's/|$$//'); \
		echo "$$BASE_IGNORE|$$GIT_IGNORE"; \
	else \
		echo "$$BASE_IGNORE"; \
	fi \
)

.PHONY: tree clean-tree check-tree

# 🎯 Verifica se o tree está instalado
check-tree:
	@command -v tree >/dev/null 2>&1 || { \
		echo "$(RED)🚫 Erro:$(RESET) comando 'tree' não encontrado"; \
		echo "$(YELLOW)📦 Instale com:$(RESET) sudo apt install tree"; \
		exit 1; \
	}
	@echo "$(GREEN)✅ Dependência verificada:$(RESET) tree encontrado 🌳"

# 🌳 Gera a árvore do projeto
tree: check-tree
	@echo "$(BLUE)🚀 Iniciando geração da árvore do projeto$(RESET)"
	@echo "$(CYAN)🌳 Profundidade:$(RESET) 4 níveis"
	@mkdir -p $(OUTPUT_DIR)

	@if [ -n "$(GITIGNORE_PATTERNS)" ]; then \
		echo "$(GRAY)📂 Ignorando padrões do .gitignore$(RESET)"; \
		tree -a -L 7 -I "$(GITIGNORE_PATTERNS)" > $(TREE_OUTPUT); \
	else \
		echo "$(GRAY)📂 Nenhum .gitignore encontrado$(RESET)"; \
		tree -a -L 7 > $(TREE_OUTPUT); \
	fi

	@DIRS=$$(tree -a -L 7 -d -I "$(GITIGNORE_PATTERNS)" 2>/dev/null | tail -1 | awk '{print $$1}'); \
	FILES=$$(tree -a -L 7 -I "$(GITIGNORE_PATTERNS)" 2>/dev/null | tail -1 | awk '{print $$3}'); \
	echo ""; \
	echo "$(GREEN)✨ Árvore gerada com sucesso!$(RESET)"; \
	echo "$(CYAN)📊 Estatísticas:$(RESET)"; \
	echo "   📁 Diretórios: $(BOLD)$${DIRS:-0}$(RESET)"; \
	echo "   📄 Arquivos:   $(BOLD)$${FILES:-0}$(RESET)"; \
	echo ""; \
	echo "$(BLUE)📁 Arquivo salvo em:$(RESET) $(BOLD)$(TREE_OUTPUT)$(RESET)"

# 🧹 Limpa os arquivos gerados
clean-tree:
	@echo "$(YELLOW)🧹 Iniciando limpeza da pasta de saída...$(RESET)"
	@rm -rf $(OUTPUT_DIR)
	@echo "$(GREEN)🗑️  Pasta $(OUTPUT_DIR) removida com sucesso!$(RESET)"
