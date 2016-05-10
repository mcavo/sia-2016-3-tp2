% SCRIPT TO TEST MULTILAYER NETWORK

function ret = test_xor()
	% initialize net
	nett = initialize_mutilayer_network([3 5 2 1],-0.5,0.5);
	% XOR training set
	t = get_training_set(3, @xor);
	% Learn
	net = multilayer_perceptron_batch_adaptative_etha(nett,t,0.1,@tanh_ft,@tanh_ft_der,1,0.5,0.9,0.4,0.05);
	% Check
	printf("Checking XOR with: betha=1, g=tanh, err=0.1, n=0.5, alpha=0.9, a=0.5, b=0.05\n");
	get_network_output(net, t{1}, @tanh_ft,1) 

end