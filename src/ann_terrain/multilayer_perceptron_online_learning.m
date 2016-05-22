% smart_net = multilayer_perceptron_online_learning(net,t,t2,err,g,g_der,betha,n,alpha,a,b,K,random,p)
%
% Output
% smart_net : trained neural network - cell array of M elements - M the amount of layers (hidden + output)
% 	* smart_net{m}:	matrix (I+1)xO - I amount of input values - O amount of output values
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
% lr1: learning rate for the training set
% lr2: learning rate for the testing set
% max_seasons:
% g: activation fuction
% g_der:
% betha: betha
% n: etha
% alpha: alpha
% a:
% b:
% K:
% random:
% p:
function smart_net = multilayer_perceptron_online_learning(net,t,t2,lr1,lr2,max_seasons,g,g_der,betha,n,alpha,a,b,K,random,p)

	tic_online = tic();
	N = size(t{1})(1); N2 = size(t2{1})(1); M = size(net)(2); I = size(t{1})(2); S = size(t{2})(2); 

	V = feedfoward(net,t{1},g,betha);

	E=(0.5*sum(sum((t{2}-V{M}).^2))/N);

	V2 = feedfoward(net,t2{1},g,betha);

	E2 = (0.5*sum(sum((t2{2}-V2{M}).^2))/N2);

	alpha_val = alpha; counter = 0;
	seasons = 0; patterns = 0;

	xerr(1) = 0; yerr(1) = E; xerr2(1) = 0; yerr2(1) = E2; xetha(1) = 0; yetha(1) = n;
	
	figure (1)
	plot(xerr(1), yerr(1));
	vh = get(gca,'children');
	title('Error variation - Training set', 'fontsize', 20);
    xlabel('Step [Season]', 'fontsize', 15, 'fontname', 'avenir next');
    ylabel('Error', 'fontsize', 15, 'fontname', 'avenir next');
    figure(2)
	plot(xetha(1), yetha(1));
	vh2 = get(gca,'children');
	title('Etha variation', 'fontsize', 20, 'fontname', 'avenir next');
    xlabel('Step [Pattern]', 'fontsize', 15, 'fontname', 'avenir next');
    ylabel('Etha', 'fontsize', 15, 'fontname', 'avenir next');

    for m=1:M
		deltaW{m} = zeros(size(net{m}));
	end

    while (E > lr1 && seasons < max_seasons)

    	seasons = seasons+1;
    	vec = randperm(N);

		for k=1:N
			patterns = patterns+1;
			%we must update V for pattern k
			V_k = feedfoward(net,t{1}(vec(k),:),g,betha);
			oldNet = net;
			[net,deltaW] = backpropagation(net,t{1}(vec(k),:),t{2}(vec(k),:),V_k,g_der,alpha,betha,deltaW,n);
			
			V = feedfoward(net,t{1},g,betha);

			oldE = E;

			E=(0.5*sum(sum((t{2}-V{M}).^2))/N);

			if (a != 0 && b != 0)
				
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
					if(!random || rand()<=p) % random => rand
						n = n*(1-b);
						net = oldNet;
						E = oldE;
						E2 = oldE2;
						yerr(end) = E;
						yerr2(end) = E2;
					end
				end
			end	
			xetha(end+1)=patterns;
			yetha(end+1)=n;
			
		end

		V2 = feedfoward(net,t2{1},g,betha);
		E2=(0.5*sum(sum((t2{2}-V2{M}).^2))/N2);
		xerr(end+1)=seasons; yerr(end+1)=E;
		xerr2(end+1)=seasons; yerr2(end+1)=E2;



		if(mod(seasons,5000)==0)
			figure(1)
			set(vh, 'xdata',xerr, 'ydata', yerr);
			figure(2)
			set(vh2, 'xdata',xetha, 'ydata', yetha); 
		end
    end

    toc(tic_online);

    figure(1)
	set(vh, 'xdata',xerr, 'ydata', yerr);

	figure(2)
	set(vh2, 'xdata',xetha, 'ydata', yetha); 

	figure(3)
	hold on
	plot(xerr2, yerr2, 'r');
	legend('Testing set');
	plot(xerr, yerr, 'g', 'DisplayName', 'Training set');
	title('Error variation - Testing set vs Training set', 'fontsize', 20);
    xlabel('Step [Season]', 'fontsize', 15, 'fontname', 'avenir next');
    ylabel('Error', 'fontsize', 15, 'fontname', 'avenir next');
	hold off

    printf('Training set Error:',E);
    printf('Testing set Error: %d\n',E2);
    printf('Analyzed seasons:\t%d\n',seasons);
    printf('Analyzed patterns:\t%d\n',patterns);
    lr_t1 = mean(((t{2}-V{M}).^2)' < lr1)
	printf('Training Sample Learnt:\t%f%%\n',lr_t1);
	V = feedfoward(net,t2{1},g,betha);
	lr_t2 = mean(((t2{2}-V2{M}).^2)' < lr2)
    printf('Testing Sample Learnt:\t%f%%\n',lr_t2);

    smart_net = net;

end
