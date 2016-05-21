function [retnet,deltaW] = backpropagation_online (net,V,g_der,betha,deltaW)

	delta{M} = g_der(betha,V_k{M}).*(t{2}(vec(k),:)-V_k{M});

	for m=M:-1:2
		delta{m-1} = g_der(betha,V_k{m-1}).*(delta{m}*(net{m}(2:end,:))');
		newDeltaW = n*[ -1 V_k{m-1}]'*delta{m};
		net{m} = net{m} + newDeltaW +alpha*deltaW{m};
		deltaW{m} = newDeltaW;
	end

	newDeltaW = n*[ -1 t{1}(vec(k),:)]'*delta{1};
	net{1} = net{1} + newDeltaW +alpha*deltaW{1};
	deltaW{1} = newDeltaW;

	retnet = net;

end