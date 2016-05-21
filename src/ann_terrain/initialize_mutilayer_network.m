function net = initialize_mutilayer_network(layer_sizes,minlim,maxlim)
	d = maxlim-minlim;
	for k= 1:(size(layer_sizes)(2)-1)
		rand("seed", now);
		net{k} = (rand(layer_sizes(k)+1,layer_sizes(k+1)).*d).+minlim;
	end
end