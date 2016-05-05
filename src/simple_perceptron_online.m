% err: error
% t: training set - Cell array
% t{1}: matrix NxM - N amount of test cases - M amount of input values
% t{2}: matrix NxS - N amount of test cases - S amount output values
% g: transference function
% n: etha
function net = simple_perceptron_online (err, t, g, n)
	N = size(t{1})(1); M = size(t{1})(2); S = size(t{2})(2);
	W = rand(M+1,S).*2.-1;	% random values between -1,1

	i = 0;

	while( 0.5*sum(sum((t{2}-g(-[ ones(N,1).*(-1) t{1}] * W)).^2)) > err ) 
		i = i + 1;
		vec = randperm(N);
		for k=1:N
			W = W + n * [ -1 ; (t{1}(vec(k),:))'] * (t{2}(vec(k),:)-g([ -1 t{1}(vec(k),:)] * W));
		end
	end
	i
	net = W;

end