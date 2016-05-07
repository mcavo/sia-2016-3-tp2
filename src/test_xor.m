% SCRIPT TO TEST MULTILAYER NETWORK

function ret = test_xor()
	% initialize net
	nett = initialize_mutilayer_network([2 4 1],-0.5,0.5);
	% XOR training set
	t = get_training_set(2, @xor);
	% Learn
	net = multilayer_perceptron_online(nett,t,0.01,@tanh_ft,@tanh_ft_der,0.5,1);
	% Check
	printf("Checking XOR with: b=1, g=tanh, err=0.01, n=0.5\n");
	get_network_output(net, t{1}, @tanh_ft,1) 

	% Learn
	net = multilayer_perceptron_online(nett,t,0.01,@exp_ft,@exp_ft_der,0.5,1);
	% Check
	printf("Checking XOR with: b=1, g=exp, err=0.01, n=0.5\n");
	get_network_output(net, t{1}, @exp_ft,1) 

end