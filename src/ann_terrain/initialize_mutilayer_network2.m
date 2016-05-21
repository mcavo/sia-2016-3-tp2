function net = initialize_mutilayer_network2(layer_sizes)
	for k= 1:(size(layer_sizes)(2)-1)
		k_i = layer_sizes(k)+1
		1/(k_i^2)
		2/(k_i^2)
		net{k} = (rand(layer_sizes(k)+1,layer_sizes(k+1)))*(2/(k_i^2))-1/(k_i^2);
	end
end