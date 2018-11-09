function [x,f]=Initialize(pNo,s)

    global c;
    global minx;
    global maxx;
    global minv;
    global maxv;


    % minv=.15.*minx;
    % maxv=.15.*maxx;

    maxv=maxx-minx;
    minv=-maxv;

    % maxv=repmat(.05,1,c*s);
    % minv=repmat(-.05,1,c*s);

    f=zeros(1,pNo);

    %x=random('unif',minx,maxx,pNo,c*s);
    x=random('unif',ones(pNo,1)*minx,ones(pNo,1)*maxx,pNo,s);
    %x=mvnrnd(ones(pNo,1)*best,.2*(maxx-minx));

    for i=1:pNo           
        f(i)=FitnessFunction(x(i,:));    
    end

end