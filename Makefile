# 
# Example Makefile for 16423 - Lecture 1
#
# Options for Darwin (MAC) Operating System
#
# All that follows you can probably keep as is...
#

OS := $(shell uname -s)
include Makefile_$(OS)

# Files which require compiling
SOURCE_FILES=\

# Source files which contain a int main(..) function
SOURCE_FILES_WITH_MAIN=\
	src/Show_Lena.cpp\

SOURCE_OBJECTS=\
        $(patsubst %.cpp,%.o,$(SOURCE_FILES))\
	$(patsubst %.cpp,%.o,$(TORCH_FILES))

ALL_OBJECTS=\
	$(SOURCE_OBJECTS)\
	$(patsubst %.cpp,%.o,$(SOURCE_FILES_WITH_MAIN))

DEPENDENCY_FILES=\
	$(patsubst %.o,%.d,$(ALL_OBJECTS)) 

all: Show_Lena

%.o: %.cpp Makefile
	@# Make dependecy file
	$(CXX) -MM -MT $@ -MF $(patsubst %.cpp,%.d,$<) $(CFLAGS) $(DEFINES) $(INCLUDES) $<
	@# Compile
	$(CXX) $(CFLAGS) $(DEFINES) $(INCLUDES) -c -o $@ $< 

#	-include $(DEPENDENCY_FILES)

# Executables to compile
Show_Lena: $(ALL_OBJECTS)
	$(CXX) -o $@ $(SOURCE_OBJECTS) src/Show_Lena.o $(LDFLAGS) $(LIBRARIES) $(INCLUDES)

.PHONY: clean
clean:
	@echo "Cleaning"
	@for pattern in '*~' '*.o' '*.d' ; do \
		find . -name "$$pattern" | xargs rm ; \
	done

