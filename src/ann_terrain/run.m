config

if !smart_initialization
	nett = initialize_mutilayer_network(net_arq,minlim,maxlim);
else
	nett = initialize_mutilayer_network2(net_arq);
end
	

if batch
	net = multilayer_perceptron_batch_learning(nett,t,t2,err,lr,max_seasons,g,g_der,betha,n,alpha,a,b,K,random,p)
else
	net = multilayer_perceptron_online_learning(nett,t,t2,err,lr,max_seasons,g,g_der,betha,n,alpha,a,b,K,random,p)
end