%this fct plots values b as the system evolves and moves the x axis
%accordingly
function y=dynamic_plot(x,b,t,step,colour)
    y = [ x, b ];
    plot(x,colour);
    if ((t/step)-50 < 0)
        startSpot = 0;
    else
        startSpot = (t/step)-50;
    end
    axis([ startSpot, (t/step+10), 0, 1]);
    drawnow;
end