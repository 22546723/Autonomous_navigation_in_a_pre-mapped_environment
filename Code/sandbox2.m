x = [0 0 2];
y = [0 2 3];
R_min = 0.1; %m

m_ab = (y(2) - y(1))/(x(2) - x(1));
m_bc = (y(3) - y(2))/(x(3) - x(2));

c_ab = y(2) - m_ab*x(2);
c_bc = y(2) - m_bc*x(2);

diff_x_ab = R_min/sqrt(1+m_ab^2);
pnt_ab = [diff_x_ab + x(2); m_ab*diff_x_ab + y(2)];

diff_x_bc = R_min/sqrt(1+m_bc^2);
pnt_bc = [diff_x_bc + x(2); m_bc*diff_x_bc + y(2)];

m_ab_p = -1/m_ab;
m_bc_p = -1/m_bc;

c_ab_p = pnt_ab(2) - m_ab_p*pnt_ab(1);
c_bc_p = pnt_bc(2) - m_bc_p*pnt_bc(1);

x_mid = (c_bc_p - c_ab_p)/(m_ab_p - m_bc_p);
y_mid = m_ap_p * x_mid + c_ab_p;

R = sqrt((x_mid - pnt_ab(1))^2 + (y_mid - pnt_ab(2))^2);

hold on
plot(x, y)
plot(pnt_ab(1), pnt_ab(2), pnt_bc(1), pnt_bc(2), 'o')
plot(x_mid, y_mid, 'o')
hold off
grid on
