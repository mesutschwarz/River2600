# Derleyici ve bayraklar
CC = lcc
CFLAGS = -debug -Wa-l -Wl-m -Wl-j

# Dizin yapısı
SRCDIR = src
BUILDDIR = build

# Alt dizinleri otomatik bul
SRCDIRS := $(shell find $(SRCDIR) -type d)

# Tüm .c dosyalarını bul
SOURCES := $(foreach dir,$(SRCDIRS),$(wildcard $(dir)/*.c))

# Object dosyaları için .c -> .o dönüşümü
OBJECTS := $(SOURCES:$(SRCDIR)/%.c=$(BUILDDIR)/%.o)

# Hedef ROM
TARGET = $(BUILDDIR)/rom.gb

# Hedefler
.PHONY: all clean

all: clean $(TARGET)

$(TARGET): $(OBJECTS)
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -o $@ $^

$(BUILDDIR)/%.o: $(SRCDIR)/%.c
	@mkdir -p $(dir $@)
	$(CC) $(CFLAGS) -c -o $@ $<

clean:
	rm -rf $(BUILDDIR)/*

# Derlenen dosyaları göster
list:
	@echo "Source directories:"
	@echo $(SRCDIRS)
	@echo
	@echo "Source files:"
	@echo $(SOURCES)