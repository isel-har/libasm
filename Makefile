NAME = libasm

LIB_NAME = libasm.a

SRCS = src/ft_strlen.s \
	src/ft_strcpy.s \
	src/ft_strcmp.s \
	src/ft_write.s \
	src/ft_read.s \
	src/ft_strdup.s \
	src/ft_atoi_base.s \
	src/ft_create_elem.s \
	src/ft_list_push_front.s \
	src/ft_list_size.s \
	src/ft_list_sort.s \
	src/ft_list_remove_if.s \

cc = gcc
CFALGS = -Wall -Wextra -Werror
NASM = nasm
NASMFLAGS = -f elf64

OBJ = $(SRCS:.s=.o)

%.o : %.s
	$(NASM) $(NASMFLAGS) $< -o $@

all : $(NAME)

$(NAME) : $(OBJ)
	ar rcs $(LIB_NAME) $(OBJ)

ccproject :
	$(CC) $(CFLAGS) -I inc/ main.c $(LIB_NAME) -o test
	
clean :
	rm -f $(OBJ)

fclean : clean
	rm -f $(LIB_NAME)


re : fclean all
