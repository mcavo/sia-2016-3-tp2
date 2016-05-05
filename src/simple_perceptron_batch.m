% err: error
% t: training set - Cell array
% t{1}: matrix NxM - N amount of test cases - M amount of input values
% t{2}: matrix NxS - N amount of test cases - S amount output values
% g: transference function
% n: etha
function net = simple_perceptron_batch (err, t, g, n)
	N = size(t{1})(1); M = size(t{1})(2); S = size(t{2})(2);
	W = rand(M+1,S).*2.-1;

	while( 0.5*sum(sum((t{2}-g([ ones(N,1).*(-1) t{1}] * W)).^2)) > err )
		deltaW = zeros(M+1,S);
		for k=1:N
			deltaW = deltaW + n * [ -1 ; (t{1}(k,:))'] * (t{2}(k,:)-g([ -1 t{1}(k,:)] * W));
		end
		W = W + deltaW;

	end

	net = W;

end