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
% a:
% b:
function smart_net = multilayer_perceptron_batch_adaptative_etha(net,t,err,g,g_der,betha,n,alpha,a,b)
	N = size(t{1})(1); I = size(t{1})(2); S = size(t{2})(2); M = size(net)(2);

	K=10; % Counter limit.
	counter = 0;
	alpha_val = alpha;
	oldE = err;
	oldNet = net;

	layer_in = t{1};
	for m=1:M
		layer_out = g(betha,([(ones(N,1)*(-1)) layer_in]*net{m}));
		V{m} = layer_out; % g(hm)
		layer_in = layer_out;

		oldDeltaW{m} = zeros(size(net{m}));
		newDeltaW{m} = zeros(size(net{m}));
	end

	% TODO: Preguntar por el historial de redes.... 
	while ((E=(0.5*sum(sum((t{2}-V{M}).^2))/N)) > err)

		alpha = alpha_val;
		if (E-oldE<0)
			counter = counter + 1;
			if (counter>=K)
				n = n + a;
			end
		else
			n = n*(1-b);
			counter = 0;
			alpha = 0;
			net = oldNet;		
		end
		oldNet = net;		
		oldE = E;

		delta{M} = g_der(betha,V{M}).*(t{2}-V{M});

		for m=M:-1:2
			delta{m-1} = g_der(betha,V{m-1}).*(delta{m}*(net{m}(2:end,:))');
			newDeltaW{m} = newDeltaW{m} + n*[ ones(N,1).*(-1) V{m-1}]'*delta{m};
		end

		newDeltaW{1} = newDeltaW{1} + n*[ ones(N,1).*(-1) t{1}]'*delta{1};

		layer_in = t{1};

		for m=1:M
			net{m} = net{m} + newDeltaW{m} + alpha*oldDeltaW{m};
			oldDeltaW{m} = newDeltaW{m};
			newDeltaW{m} = zeros(size(net{m}));

			layer_out = g(betha,([(ones(N,1)*(-1)) layer_in]*net{m}));
			V{m} = layer_out; % g(hm)
			layer_in = layer_out;
		end

	end

	smart_net = net;

end
