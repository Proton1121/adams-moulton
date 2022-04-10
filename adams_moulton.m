function [x, t] = adams_moulton(f, t0, x0, T, N)
	h = (T-t0) / (N-1);
	t = [t0];
	x = [x0];
	for i = 1 : 2
		t(i+1) = t(i) + h;
		s1 = f(t(i), x(i));
		s2 = f(t(i) + h / 2, x(i) + s1 * h /2);
		s3 = f(t(i) + h / 2, x(i) + s2 * h /2);
		s4 = f(t(i+1), x(i) + s3 * h);
		x(i+1) = x(i) + (s1 + s2+s2 + s3+s3 + s4) * h / 6;
  	end;
	for n = 4:N
		t(n) = t0 + (n-1)*h;
		if n == 4
			x(4) = x(3) + h * (23/12*f(t(3),x(3))-16/12*f(t(2),x(2))+5/12*f(t(1),x(1)));
		else
			x(n) = x(n-1) + h * (55/24*f(t(n-1),x(n-1))-59/24*f(t(n-2),x(n-2))+37/24*f(t(n-3),x(n-3))-9/24*f(t(n-4),x(n-4)));
		end
		i = 0;
		while(i < 1000)
			sxnp1 = x(n);
			x(n) = x(n-1) + h * (9/24*f(t(n),x(n))+19/24*f(t(n-1),x(n-1))-5/24*f(t(n-2),x(n-2))+1/24*f(t(n-3),x(n-3)));
			i += 1;
			if(abs(x(n) - sxnp1) <= 1e-10)
				break;
			end;
		end
	end
end
