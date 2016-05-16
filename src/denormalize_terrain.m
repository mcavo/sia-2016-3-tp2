function terr_ret = denormalize_terrain(tanh_ft,terr_n,M)
	terr = zeros(size(terr_n));
	N = size(terr)(1); D = size(terr)(2);
	for k=1:D
		terr(:,k)=terr_n(:,k);
		if(tanh_ft)
			terr(:,k) = (terr(:,k).+1).*0.5;
		end
		terr(:,k) = terr(:,k).*(M(k,2)-M(k,1));
		terr(:,k) = terr(:,k).+M(k,1);
	end
	terr_ret = terr;
end