#ifndef	LIBASM_H
# define LIBASM_H


#include <unistd.h>
#include <fcntl.h>
#include <string.h>
#include <stdlib.h>
#include <stdio.h>


typedef struct s_list
{
    void            *data;
    struct s_list   *next;
} t_list;



size_t  ft_strlen(const char *__s);
char    *ft_strcpy(char *__dst, char *__src);
int     ft_strcmp(const char *__s1, const char *__s2);


ssize_t ft_write(int __fd, const void *__ptr, size_t __size);
ssize_t ft_read(int __fd, void *__ptr, size_t __size);
char    *ft_strdup(char *__s);


int         ft_atoi_base(char *__s, char *__base);

t_list	    *ft_create_elem(void *data);
void        ft_list_push_front(t_list **begin_list, void *data);
void        ft_list_sort(t_list **begin_list, int (*cmp)());
void        ft_list_remove_if(t_list **begin_list, void *data_ref, int (*cmp)(), void (*free_fct)(void *));
int         ft_list_size(t_list *begin_list);

#endif