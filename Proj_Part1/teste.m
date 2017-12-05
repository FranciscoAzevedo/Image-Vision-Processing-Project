%EX2
x=[1,0,0.1,1];y=[0,1,0.1,1];z=[0,0,0.9,1];
[nerd,cornerpoints1,nerd,nerd] = minboundbox(x,y,z,'v',1);
[nerd,cornerpoints2,nerd,nerd] = minboundbox(x,y,z,'v',2);
[nerd,cornerpoints3,nerd,nerd] = minboundbox(x,y,z,'v',3);
plot3(x,y,z,'bo','LineWidth',5);hold on;
plotminbox(cornerpoints1,'b');hold on;
plotminbox(cornerpoints2,'m');hold on;
plotminbox(cornerpoints3,'r');axis equal;grid on;hold off;