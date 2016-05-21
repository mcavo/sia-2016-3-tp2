function [retnet,deltaW] = backpropagation_online (net,t_1_k,t_2_k,V_k,g_der,alpha,betha,deltaW,n)
	M = size(net)(2);
	delta{M} = g_der(betha,V_k{M}).*(t_2_k-V_k{M});

	for m=M:-1:2
		delta{m-1} = g_der(betha,V_k{m-1}).*(delta{m}*(net{m}(2:end,:))');
		newDeltaW = n*[ -1 V_k{m-1}]'*delta{m};
		net{m} = net{m} + newDeltaW +alpha*deltaW{m};
		deltaW{m} = newDeltaW;
	end

	newDeltaW = n*[ -1 t_1_k]'*delta{1};
	net{1} = net{1} + newDeltaW +alpha*deltaW{1};
	deltaW{1} = newDeltaW;

	retnet = net;

end
