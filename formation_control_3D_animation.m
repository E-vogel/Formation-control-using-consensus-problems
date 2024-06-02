clear
close all

% Number of agents
n = 3500;

st = 145;

% Initial positions of agents
x0 = 2*rand(n,1)-1;
y0 = 2*rand(n,1)-1;
z0 = 2*rand(n,1)-1;

% Offset vector
RP = [100 100 100];

% Load image formation coordinates
for i = 1:150
    filename = "Trex_ani_xyzdata\Trexani" + i + ".csv";
    Trex_data_read{i} = readmatrix(filename);
    % Generate an index of the data to be extracted
    sampleIndices_Trex{i} = round(linspace(1, size(Trex_data_read{i}, 1), n));
    
    % Equally extracted data
    Trex_data{i} = Trex_data_read{i}(sampleIndices_Trex{i}, :);

    filename = "butterfly_ani_xyzdata\butterflyani" + i + ".csv";
    butterfly_data_read{i} = readmatrix(filename);
    % Generate an index of the data to be extracted
    sampleIndices_butterfly{i} = round(linspace(1, size(butterfly_data_read{i}, 1), n));
    
    % Equally extracted data
    butterfly_data{i} = butterfly_data_read{i}(sampleIndices_butterfly{i}, :);
end

% Compute initial relative positions for image formation
VS_Trex = [x0 y0 z0] + RP.*ones(n,3) - [Trex_data{1}(:,1) Trex_data{1}(:,3) Trex_data{1}(:,2)]; 

% Adjacency matrix
A = ones(n,n);

% Simulation parameters
fin = 0.1;
h = 0.0002;
t = 0:h:h*150;

% Degree matrix and Laplacian matrix
d = [];
for i=1:numel(x0)
    d=[d sum(A(i,:))];
end

D=diag(d);
L = D - A;

% figure
f = figure;
f.Color = 'k';

% Initialize video writer
v = VideoWriter('formation_control_3D_animation.avi','Uncompressed AVI');
open(v);
view(0,20)


% Plot initial positions
s = scatter3(x0,y0,z0,1,'filled','w');
daspect([1 1 1])
box on
set(gca,'TickLabelInterpreter','latex')
set(gca, 'LooseInset', get(gca, 'TightInset'));

% Simulation loop for Trex formation
for i = 1:numel(t)-1
    s.XData = s.XData.' - L*VS_Trex(:,1)*h;
    s.YData = s.YData.' - L*VS_Trex(:,2)*h;
    s.ZData = s.ZData.' - L*VS_Trex(:,3)*h;
  
    VS_Trex = [s.XData.' s.YData.' s.ZData.'] + RP.*ones(n,3) - [Trex_data{i}(:,1) Trex_data{i}(:,3) Trex_data{i}(:,2)];
    
    VS_Trex = VS_Trex - L*VS_Trex*h;
    view(st+i/3,20)
    axis([-4.5 4.5 -10 4 -2.5 4])
    axis off
    set(gca, 'LooseInset', get(gca, 'TightInset'));
    frame = getframe(gcf);
    writeVideo(v,frame);
end

VS_butterfly = [s.XData.' s.YData.' s.ZData.'] + RP.*ones(n,3) - 80*[butterfly_data{1}(:,1) butterfly_data{1}(:,3) butterfly_data{1}(:,2)];

% Simulation loop for butterfly formation
for j = 1:3
    for i = 1:numel(t)/3
        s.XData = s.XData.' - L*VS_butterfly(:,1)*h*0.2*j;
        s.YData = s.YData.' - L*VS_butterfly(:,2)*h*0.2*j;
        s.ZData = s.ZData.' - L*VS_butterfly(:,3)*h*0.2*j;
        
        VS_butterfly = [s.XData.' s.YData.' s.ZData.'] + RP.*ones(n,3) - 80*[butterfly_data{i}(:,1) butterfly_data{i}(:,3) butterfly_data{i}(:,2)];
        
        VS_butterfly = VS_butterfly - L*VS_butterfly*h*0.2*j;
        view(st+i/3+150/3+50*(j-1)/3,20)
        axis([-4.5 4.5 -10 4 -2.5 4])
        axis off
        set(gca, 'LooseInset', get(gca, 'TightInset'));
        frame = getframe(gcf);
        writeVideo(v,frame);
    end
end
close(v);
