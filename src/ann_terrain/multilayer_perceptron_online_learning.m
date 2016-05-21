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
function smart_net = multilayer_perceptron_online_learning(net,t,err,g,g_der,betha,n,alpha,a,b,K,random,p)

	N = size(t{1})(1); I = size(t{1})(2); S = size(t{2})(2); M = size(net)(2);

	V = feedfoward(net,t{1},g,b);

	E=(0.5*sum(sum((t{2}-V{M}).^2))/N);

	seasons = 0; patterns = 0;

	step = 0;
	xerr(1) = 0; yerr(1) = E; xetha(1) = 0; yetha(1) = n;
	figure (1)
	plot(xerr(1), yerr(1));
	vh = get(gca,'children');
	title('Error variation', 'fontsize', 20);
    xlabel('Step', 'fontsize', 15, 'fontname', 'avenir next');
    ylabel('Error', 'fontsize', 15, 'fontname', 'avenir next');
    figure(2)
	plot(xetha(1), yetha(1));
	vh2 = get(gca,'children');
	title('Etha variation', 'fontsize', 20, 'fontname', 'avenir next');
    xlabel('Step', 'fontsize', 15, 'fontname', 'avenir next');
    ylabel('Etha', 'fontsize', 15, 'fontname', 'avenir next');

    for m=1:M
		deltaW{m} = zeros(size(net{m}));
	end

    while (E > err)

    	vec = randperm(N);
		for k=1:N

			patterns = patterns+1;
			%we must update V for pattern k
			V_k = feedfoward(net,t{1}(vec(k),:),g,betha);

			[net,deltaW] = backpropagation_online (net,V_k,g_der,betha)

		end

		seasons = seasons+1;

		V = feedfoward(net,t{1},g,betha);

		step = step+1;
		E=(0.5*sum(sum((t{2}-V{M}).^2))/N);

		xerr(end+1)=step;
		yerr(end+1)=E;

		if (E-oldE<0)
			alpha = alpha_val;
			counter = counter + 1;
			if (counter>=K)
				n = n + a;
			end
		else
			counter = 0;
			alpha = 0;
			% 
			if(!random || rand()>0.5) % random => rand
				n = n*(1-b);
				net = oldNet;
				E = oldE;
				xerr(end+1)=step;
				yerr(end+1)=E;
			end
		end

		figure(1)
		set(vh, 'xdata',xerr, 'ydata', yerr);

		xetha(end+1)=step; yetha(end+1)=n;

		figure(2)
		set(vh2, 'xdata',xetha, 'ydata', yetha); 

    end

    printf('Analyzed seasons:\t%d\n',seasons);
    printf('Analyzed patterns:\t%d\n',patterns);

    smart_net = net;

end