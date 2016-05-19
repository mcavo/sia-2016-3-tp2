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
function smart_net = multilayer_perceptron_batch_momentum(net,t,err,g,g_der,betha,n,alpha)
	N = size(t{1})(1); I = size(t{1})(2); S = size(t{2})(2); M = size(net)(2);

	V = feedfoward(net,t{1},g,betha);

	E=(0.5*sum(sum((t{2}-V{M}).^2))/N);

	step = 0;
	xerr(1) = 0;
	yerr(1) = E;
	figure (1)
	plot(xerr(1), yerr(1));
	vh = get(gca,'children');
	title('Error variation', 'fontsize', 20);
    xlabel('Step', 'fontsize', 15, 'fontname', 'avenir next');
    ylabel('Error', 'fontsize', 15, 'fontname', 'avenir next');
    figure (2)
	plot(xerr(1), yerr(1));
	vh2 = get(gca,'children');
	title('Error variation', 'fontsize', 20);
    xlabel('Step', 'fontsize', 15, 'fontname', 'avenir next');
    ylabel('Error', 'fontsize', 15, 'fontname', 'avenir next');

	for m=1:M
		oldDeltaW{m} = zeros(size(net{m}));
	end

	while (E > err)

		% a * sum (deltaW) = sum (a * deltaW)

		delta{M} = g_der(betha,V{M}).*(t{2}-V{M});

		for m=M:-1:2
			delta{m-1} = g_der(betha,V{m-1}).*(delta{m}*(net{m}(2:end,:))');
			newDeltaW{m} = n*[ ones(N,1).*(-1) V{m-1}]'*delta{m};

			net{m} = net{m} + newDeltaW{m} + alpha*oldDeltaW{m};
			oldDeltaW{m} = newDeltaW{m};
		end

		newDeltaW{1} = n*[ ones(N,1).*(-1) t{1}]'*delta{1};
		net{1} = net{1} + newDeltaW{1} + alpha*oldDeltaW{1};
		oldDeltaW{1} = newDeltaW{1};

		V = feedfoward(net,t{1},g,betha);

		E=(0.5*sum(sum((t{2}-V{M}).^2))/N);
		step = step+1;
		xerr(end+1)=step;
		yerr(end+1)=E;

		figure(1)
		set(vh, 'xdata',xerr, 'ydata', yerr);
		figure(2)
		set(vh2, 'xdata',xerr, 'ydata', yerr);

	end

	smart_net = net;

end
