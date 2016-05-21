function [M terr_n] = normalize_terrain(tanh_ft,terr)
	N = size(terr)(1); D = size(terr)(2);
	M = zeros(D,2);
	for k=1:D
		terr_k = terr(:,k);
		M(k,1)=min(terr_k); M(k,2)=max(terr_k);
	
		%Normalization
		terr_n(:,k) = terr_k .- M(k,1); 
		terr_n(:,k) = terr_n(:,k).*(1/max(terr_n(:,k))); % between 0 and 1
		if tanh_ft
			terr_n(:,k) = terr_n(:,k).*2-1; % between -1 and 1
		end
	end
end