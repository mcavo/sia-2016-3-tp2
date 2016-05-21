% Parameters
% net:		neural network - cell array of M elements - M the amount of layers (hidden + output)
% net{m}:	matrix (I+1)xO - I amount of input values - O amount of output values
% t: training set - Cell array
% t{1}: matrix NxI - N amount of test cases - I amount of input values
% t{2}: matrix NxS - N amount of test cases - S amount output values
% err: error
% n: etha
% b: betha
function smart_net = multilayer_perceptron_online(net,t,err,g,g_der,n,b)
	N = size(t{1})(1); I = size(t{1})(2); S = size(t{2})(2); M = size(net)(2);

	V = feedfoward(net,t{1},g,b);

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

	while (E > err)
		vec = randperm(N);
		for k=1:N
			%we must update V for pattern k

			V_k = feedfoward(net,t{1}(vec(k),:),g,b);

			delta{M} = g_der(b,V_k{M}).*(t{2}(vec(k),:)-V_k{M});

			for m=M:-1:2
				delta{m-1} = g_der(b,V_k{m-1}).*(delta{m}*(net{m}(2:end,:))');
				net{m} = net{m} + n*[ -1 V_k{m-1}]'*delta{m};
			end

			net{1} = net{1} + n*[ -1 t{1}(vec(k),:)]'*delta{1};

		end

		V = feedfoward(net,t{1},g,b);

		step = step+1;
		E=(0.5*sum(sum((t{2}-V{M}).^2))/N);

		xerr(end+1)=step;
		yerr(end+1)=E;

		figure(1)
		set(vh, 'xdata',xerr, 'ydata', yerr);
		figure(2)
		set(vh2, 'xdata',xerr, 'ydata', yerr);
		pause(0.1);
	end

	smart_net = net;

end