function net = test_terrain()
	terr = load("../data/terrain5-all.txt");
	[M terr_n] = normalize_terrain(1,terr);

	%ttrain = load("../data/input/mitad1.txt");


	t{1} = terr(:,1:2);
	t{2} = terr(:,3);

	%t = get_training_set(4,@xor);
	%t{1} = t{1}*2-1;
	%t{2} = t{2}*2-1;

	%nett = initialize_mutilayer_network([2 5 2 1],-0.5,0.5);
	nett = initialize_mutilayer_network([2 5 1],-0.5,0.5);

	err=0.001; g=@tanh_ft; g_der=@tanh_ft_der; betha=0.5; n=0.02; alpha=0; a=0; b=0;

	%net = multilayer_perceptron_online_adaptive_etha(nett,t,err,g,g_der,betha,n,alpha,a,b,0);
	net = multilayer_perceptron_batch_adaptive_etha(nett,t,err,g,g_der,betha,n,alpha,a,b,0)
	o = feedfoward(net, t{1}, g, betha);
	O = o{size(net)(2)}
	% terr_out = denormalize_terrain(1,O,M);

	% figure(3)
	% hold on
	% plot3(terr(:,1),terr(:,2),terr(:,3),'r.')
	% plot3(terr(:,1),terr(:,2),terr_out,'g.')
	% hold off

	% figure (4)
	% plot(1:length(terr_out),(terr(:,3)-terr_out).^2,'p');

	%me = load("../data/mesh.txt");
	%mesh(me(:,1),me(:,2),me(:,3:end)')
end