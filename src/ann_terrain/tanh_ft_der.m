function ret = tanh_ft_der(b,g)
	ret = b*(1-g.^2);
end