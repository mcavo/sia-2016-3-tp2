% Parameters
% net: neural network - cell array of M elements - M the amount of layers (hidden + output)
% 	* net{m}:	matrix (I+1)xO - I amount of input values - O amount of output values
% err: error
% t: training set - Cell array
% 	* t{1}: matrix NxI - N amount of test cases - I amount of input values
% 	* t{2}: matrix NxS - N amount of test cases - S amount output values
% g: 
% g_der:
% betha: betha
% n: etha
% alpha: alpha
function smart_net = multilayer_perceptron_online_momentum(net,t,err,g,g_der,betha,n,alpha)
	N = size(t{1})(1); I = size(t{1})(2); S = size(t{2})(2); M = size(net)(2);

	layer_in = t{1};
	for m=1:M
		deltaW{m} = zeros(size(net{m}));
		layer_out = g(betha,([(ones(N,1)*(-1)) layer_in]*net{m}));
		V{m} = layer_out; % g(hm)
		layer_in = layer_out;
	end

	while (0.5*sum(sum((t{2}-V{M}).^2))/N > err)

		vec = randperm(N);

		for k=1:N
			%we must update V for pattern k
			layer_in = t{1}(vec(k),:);
			for m=1:M
				layer_out = g(betha,([-1 layer_in]*net{m}));
				V{m}(vec(k),:) = layer_out; % g(hm,vec(k))
				layer_in = layer_out;
			end

			delta{M} = g_der(b,V{M}(vec(k),:)).*(t{2}(vec(k),:)-V{M}(vec(k),:));

			for m=M:-1:2
				delta{m-1} = g_der(betha,V{m-1}(vec(k),:)).*(delta{m}*(net{m}(2:end,:))');
				newDeltaW = n*[ -1 V{m-1}(vec(k),:)]'*delta{m}
				net{m} = net{m} + newDeltaW +alpha*deltaW{m};
				deltaW{m} = newDeltaW;
			end

			newDeltaW = n*[ -1 t{1}(vec(k),:)]'*delta{1}
			net{1} = net{1} + newDeltaW +alpha*deltaW{1};
			deltaW{1} = newDeltaW;

		end

		layer_in = t{1};
		for m=1:M
			layer_out = g(betha,([(ones(N,1)*(-1)) layer_in]*net{m}));
			V{m} = layer_out; % g(hm)
			layer_in = layer_out;
		end

	end

	smart_net = net;

end