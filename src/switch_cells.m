function system = switch_cells(k,l,m,n,sys)
    system = sys;
    
    system(k,l)=sys(m,n);
    system(m,n)=sys(k,l);

end