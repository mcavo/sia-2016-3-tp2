% smart_net = multilayer_perceptron_online_learning(net,t,t2,err,g,g_der,betha,n,alpha,a,b,K,random,p)
%
% Output
% smartnet : trained neural network - cell array of M elements - M the amount of layers (hidden + output)
% 	* smartnet{m}:	matrix (I+1)xO - I amount of input values - O amount of output values
%
% Input
% net: neural network - cell array of M elements - M the amount of layers (hidden + output)
% 	* net{m}:	matrix (I+1)xO - I amount of input values - O amount of output values
% t: training set - Cell array
% 	* t{1}: matrix NxI - N amount of training cases - I amount of input values
% 	* t{2}: matrix NxS - N amount of training cases - S amount output values
% t2: testing set - Cell array
% 	* t2{1}: matrix N2xI - N2 amount of test cases - I amount of input values
% 	* t2{2}: matrix N2xS - N2 amount of test cases - S amount output values
% err: error
% err2: error 2
% g: 
% g_der:
% betha: betha
% n: etha
% alpha: alpha
% a:
% b:
% K:
% random:
% p:
function smart_net = multilayer_perceptron_batch_learning(net,t,t2,err,err2,g,g_der,betha,n,alpha,a,b,K,random,p)
	tic_batch = tic();
	N = size(t{1})(1); M = size(net)(2); I = size(t{1})(2); S = size(t{2})(2); 

	V = feedfoward(net,t{1},g,betha);

	E=(0.5*sum(sum((t{2}-V{M}).^2))/N);

	V2 = feedfoward(net,t2{1},g,betha);

	E2 = (0.5*sum(sum((t2{2}-V{M}).^2))/N);
	
	alpha_val = alpha; counter = 0;
	seasons = 0; patterns = 0;
	counter2 = 0;

	step = 0;
	xerr(1) = 0; 
	yerr(1) = E; 
	xetha(1) = 0; 
	yetha(1) = n;
	xerr2(1) = 0;
	yerr2(1) = E2;

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
		oldDeltaW{m} = zeros(size(net{m}));
	end

    while (E > err)

    	seasons = seasons+1;
    	patterns = patterns+N;

    	oldNet = net;
    	[net,oldDeltaW] = backpropagation(net,t{1},t{2},V,g_der,alpha,betha,oldDeltaW,n);

    	V = feedfoward(net,t{1},g,betha);
    	V2 = feedfoward(net, t2{1}, g, betha);
		oldE = E;
		oldE2 = E2;
		E = (0.5*sum(sum((t{2}-V{M}).^2))/N);
		E2 = (0.5*sum(sum((t2{2}-V{M}).^2))/N);
		step = step + 1;
		xerr(end+1) = step;
		yerr(end+1) = E;
		xerr2(end+1) = step;
		yerr2(end+1) = E2;

		if(a!=0 && b!=0)
			if (E - oldE < 0)
				alpha = alpha_val;
				counter = counter + 1;
				if (counter >= K)
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
					E2 = oldE2;
					yerr(end) = E;
					yerr2(end) = E2;
				end
			end
		end
		xetha(end + 1) = step;
		yetha(end + 1) = n;
		counter2++;
		if(counter2 == 5000)
			counter2 = 0;
			figure(1)
			set(vh, 'xdata',xerr, 'ydata', yerr);

			figure(2)
			set(vh2, 'xdata',xetha, 'ydata', yetha);
		end
    end

    toc(tic_batch);

    figure(1)
	set(vh, 'xdata',xerr, 'ydata', yerr);

	figure(2)
	set(vh2, 'xdata',xetha, 'ydata', yetha);

	figure(3)
	hold on
	plot(xerr2, yerr2, 'r');
	plot(xerr, yerr, 'g');
	hold off

    printf('Analyzed seasons:\t%d\n',seasons);
    printf('Analyzed patterns:\t%d\n',patterns);
    lr_t1 = mean(((t{2}-V{M}).^2)' < err);
	printf('Training Sample Learnt:\t%f%%\n',lr_t1);
	V = feedfoward(net,t2{1},g,betha);
	lr_t2 = mean(((t2{2}-V{M}).^2)' < err2);
    printf('Testing Sample Learnt:\t%f%%\n',lr_t2);

    smart_net = net;

end
