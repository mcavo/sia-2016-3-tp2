function [retnet,deltaW] = backpropagation (net,t_1,t_2,V,g_der,alpha,betha,deltaW,n)
	M = size(net)(2);

	N = size(t_1)(1);

	


	delta{M} = g_der(betha,V{M}).*(t_2-V{M});

	for m=M:-1:2
		delta{m-1} = g_der(betha,V{m-1}).*(delta{m}*(net{m}(2:end,:))');
		newDeltaW = n*[ ones(N,1).*(-1) V{m-1}]'*delta{m};
		net{m} = net{m} + newDeltaW +alpha*deltaW{m};
		deltaW{m} = newDeltaW;
	end

	newDeltaW = n*[ ones(N,1).*(-1) t_1]'*delta{1};
	net{1} = net{1} + newDeltaW +alpha*deltaW{1};
	deltaW{1} = newDeltaW;

	retnet = net;

end
