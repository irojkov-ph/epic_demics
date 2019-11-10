%this fct plots values b as the system evolves and moves the x axis
%accordingly
function y=dynamic_plot(x,b,i,colour)
    y = [ x, b ];
    plot(x,colour);
    if ((i)-10 < 0)
        startSpot = 0;
    else
        startSpot = (i)-10;
    end
    axis([ startSpot, (i+10), 0, 1]);
    drawnow;
end