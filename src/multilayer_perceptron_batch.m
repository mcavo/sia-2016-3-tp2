% Parameters
% net:		neural network - cell array of M elements - M the amount of layers (hidden + output)
% net{m}:	matrix (I+1)xO - I amount of input values - O amount of output values
% err: error
% t: training set - Cell array
% t{1}: matrix NxI - N amount of test cases - I amount of input values
% t{2}: matrix NxS - N amount of test cases - S amount output values
% n: etha
% b: betha
function smart_net = multilayer_perceptron_batch(net,t,err,g,g_der,n,b)
	N = size(t{1})(1); I = size(t{1})(2); S = size(t{2})(2); M = size(net)(2);

	layer_in = t{1};
	for m=1:M
		layer_out = g(b,([(ones(N,1)*(-1)) layer_in]*net{m}));
		V{m} = layer_out; % g(hm)
		layer_in = layer_out;
	end


	while (0.5*sum(sum((t{2}-V{M}).^2))/N > err)

		delta{M} = b*((1-(V{M}).^2)).*(t{2}-V{M});

		for m=M:-1:2
			delta{m-1} = g_der(b,V{m-1}).*(delta{m}*(net{m}(2:end,:))');
			net{m} = net{m} + n*[ ones(N,1).*(-1) V{m-1}]'*delta{m};
		end

		net{1} = net{1} + n*[ ones(N,1).*(-1) t{1}]'*delta{1};

		layer_in = t{1};
		for m=1:M
			layer_out = g(b,([(ones(N,1)*(-1)) layer_in]*net{m}));
			V{m} = layer_out; % g(hm)
			layer_in = layer_out;
		end

	end

	smart_net = net;

end