#ifndef	LIBASM_H
# define LIBASM_H

#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>

// typedef struct s_list
// {
//     void            *data;
//     struct s_list   *next;
// } t_list;


size_t  ft_strlen(const char *s);
char    *ft_strcpy(char *dst, char *src);
int     ft_strcmp(const char *s1, const char *s2);


// functions use sys calls!
ssize_t ft_write(int fd, const void *ptr, size_t size);
ssize_t ft_read(int fd, void *ptr, size_t size);
char    *ft_strdup(char *s);


// t_list	*ft_create_elem(void *data);
// void     ft_list_push_front(t_list **begin_list, void *data);
// void     ft_list_sort(t_list **begin_list, int (*cmp)());
// void     ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));

#endif