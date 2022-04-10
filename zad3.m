t0 = 1;
x0 = 1;
T = 3;
f = @(t, x) x + t.^2;
x_dokl = @(t) exp(-1)*(6*exp(t)-exp(1)*t.^2-2*exp(1)*t-2*exp(1));
t = linspace(t0, T, 1000);
plot(t, x_dokl(t), ';dokladne;');
hold on;
blad=[Inf];
for N=[10, 20, 40, 80, 160]
	[x,t] = adams_moulton(f, t0, x0, T, N);
	plot(t, x, sprintf(';N=%d;',N) );
	blad = [blad, abs(x_dokl(T) - x(end))];
	printf('N=%5d: Blad w T: %f (%f)\n', N, blad(end), blad(end-1) / blad(end));
end
hold off;
