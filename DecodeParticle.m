function z=DecodeParticle(particle,s)

    global c;

    z=zeros(c,s);

    k=1;
    for i=1:s:c*s

        z(k,:)=particle(i:i+s-1);
        k=k+1;
    end


end