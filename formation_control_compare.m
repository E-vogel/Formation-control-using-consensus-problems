clear
close all

n = 200;

x0 = 900*rand(n,1)-300;
y0 = 900*rand(n,1)-300;

VO = [100 100];
load('star_image_coordinate.mat');

VS1_star = [x0 y0] + VO.*ones(n,2) - star_data; 
VS2_star = [x0 y0] + VO.*ones(n,2) - star_data; 

A1 = randi([0 3],n);
A1(A1 > 1) = 1;
A2 = ones(n,n);

fin = 0.06;
h = 0.0001;
t = 0:h:fin;


d1 = []; d2 = [];
for i=1:numel(x0)
    d1 = [d1 sum(A1(i,:))];
    d2 = [d2 sum(A2(i,:))];
end

D1 = diag(d1);
L1 = D1 - A1;

D2 = diag(d2);
L2 = D2 - A2;

f = figure;
f.Position = [0 0 1000 500];

v = VideoWriter('formation_control_com.mp4','MPEG-4');
open(v);

color_str = parula(n);

subplot(1,2,1)
s1 = scatter(x0,y0,[],color_str,'filled');
xlim([-300 600])
ylim([-300 600])
daspect([1 1 1])
box on

title('The Sparse Graph','Interpreter','latex','FontSize',15)

set(gca,'TickLabelInterpreter','latex')
set(gca, 'LooseInset', get(gca, 'TightInset'));

subplot(1,2,2)
s2 = scatter(x0,y0,[],color_str,'filled');
xlim([-300 600])
ylim([-300 600])
daspect([1 1 1])
box on

title('The Complete Graph','Interpreter','latex','FontSize',15)

set(gca,'TickLabelInterpreter','latex')
set(gca, 'LooseInset', get(gca, 'TightInset'));
for i = 1:numel(t)-1
    s1.XData = s1.XData.' - L1*VS1_star(:,1)*h;
    s1.YData = s1.YData.' - L1*VS1_star(:,2)*h;
    VS1_star = VS1_star - L1*VS1_star*h;
    s2.XData = s2.XData.' - L2*VS2_star(:,1)*h;
    s2.YData = s2.YData.' - L2*VS2_star(:,2)*h;
    VS2_star = VS2_star - L2*VS2_star*h;
    
    frame = getframe(gcf);
    writeVideo(v,frame);
end

for i = 1:numel(t)-1
    s1.XData = s1.XData.' - L1*VS1_star(:,1)*h;
    s1.YData = s1.YData.' - L1*VS1_star(:,2)*h;
    theta = 0.005*i;
    R = [cos(theta) -sin(theta);
         sin(theta)  cos(theta)];
    star_data_r = [];
    for j = 1:n
        star_data_r = [star_data_r; star_data(j,:)*R];
    end
    VS1_star = [s1.XData.' s1.YData.'] + VO.*ones(n,2) - star_data_r; 
    VS1_star = VS1_star - L1*VS1_star*h;

    s2.XData = s2.XData.' - L2*VS2_star(:,1)*h;
    s2.YData = s2.YData.' - L2*VS2_star(:,2)*h;
    VS2_star = [s2.XData.' s2.YData.'] + VO.*ones(n,2) - star_data_r; 
    VS2_star = VS2_star - L2*VS2_star*h;
    frame = getframe(gcf);
    writeVideo(v,frame);
end
close(v);
