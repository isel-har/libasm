static int	base_size(char *bs)
{
	int	i;

	i = 0;
	while (bs[i])
		i++;
	return (i);
}

static int	has_duplicate(char *base, int len)
{
	int	i;
	int	j;

	i = 0;
	while (i < len)
	{
		j = i + 1;
		while (j < len)
		{
			if (base[i] == base[j])
				return (1);
			j++;
		}
		i++;
	}
	return (0);
}

static int	check_base(char *s)
{
	int	i;
	int	len;

	len = base_size(s);
	if (len < 2)
		return (0);
	if (has_duplicate(s, len))
		return (0);
	i = 0;
	while (s[i])
	{
		if ((s[i] >= 9 && s[i] <= 13) || s[i] == ' '
			|| s[i] == '+' || s[i] == '-')
			return (0);
		i++;
	}
	return (1);
}

static int	char_to_index(char c, char *base, int len)
{
	int	i;

	i = 0;
	while (i < len)
	{
		if (base[i] == c)
			return (i);
		i++;
	}
	return (-1);
}

int	ft_atoi_base(char *str, char *base)
{
	int		i;
	int		sign;
	long	res;
	int		len;
	int		digit;

	if (!check_base(base))
		return (0);
	len = base_size(base);
	i = 0;
	sign = 1;
	res = 0;
	while ((str[i] >= 9 && str[i] <= 13) || str[i] == ' ')
		i++;
	while (str[i] == '-' || str[i] == '+')
	{
		if (str[i] == '-')
			sign *= -1;
		i++;
	}
	digit = char_to_index(str[i], base, len);
	while (str[i] && digit != -1)
	{
		res = res * len + digit;
		i++;
		digit = char_to_index(str[i], base, len);
	}
	return ((int)(res * sign));
}