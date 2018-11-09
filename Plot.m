figure(1);

subplot(2,2,1);
plot(1:150,GAIris,':','LineWidth',2);
hold on;
plot(1:150,PSOIris,'-.','LineWidth',2);
plot(1:100,FOAIris,'LineWidth',2);
title('Iris dataset');
xlabel('NO. of iterations');
ylabel('Jm');
legend('GGAFCM','PSOFCM','FOFCM');

subplot(2,2,2);
plot(1:150,GAWine,':','LineWidth',2);
hold on;
plot(1:150,PSOWine,'-.','LineWidth',2);
plot(1:100,FOAWine,'LineWidth',2);
title('Wine dataset');
xlabel('NO. of iterations');
ylabel('Jm');
legend('GGAFCM','PSOFCM','FOFCM');

subplot(2,2,3);
plot(1:150,GAVowel,':','LineWidth',2);
hold on;
plot(1:150,PSOVowel,'-.','LineWidth',2);
plot(1:100,FOAVowel,'LineWidth',2);
title('Vowel dataset');
xlabel('NO. of iterations');
ylabel('Jm');
legend('GGAFCM','PSOFCM','FOFCM');

subplot(2,2,4);
plot(1:150,GALiver,':','LineWidth',2);
hold on;
plot(1:150,PSOLiver,'-.','LineWidth',2);
plot(1:100,FOALiver,'LineWidth',2);
title('LiverDisorder dataset');
xlabel('NO. of iterations');
ylabel('Jm');
legend('GGAFCM','PSOFCM','FOFCM');
colormap gray;

