# GaN-FET
GaN Modelling-Analysis Research League
2.7.17
I configured the model a little bit. Here I had the problem of configuration solver which I intend to solve later on. I used the parameters provided in the datasheet of GaN-FET site of which we will be using in our upcoming experiments.
3.7.17
Solver configuration is solved, there are two scopes two obtain both input voltage and output current. The output is wrong but will be worked upon later.
4.7.17
I added a function block for Id representation however there might be a wrong representation in the blocks. I will try to use another way for Id.
18.7.17
Based on the "ekran alıtısı" pic added, I tried to make another model however I encounter the problem of connecting the ideal switch to any other circuit element unlike the picture shows. I believe this is a good model as well. But I need help for a proper connection.
I tried to improve the other model as well but with little improvement. Somehow, I think, I am making a mistake connecting the elements and putting the function. Also this simulink function thing is a bit complicated since I need an if statement for the model. There are various types of function writing one of which is an "if block function writing". It did not work out well since it requires too many connections and making the model look complicated. Hence I am looking for something simple which will handle everything in one simple MATLAB function with if statements inside. However, I tried this and it looks not possibe this way. I am a little bit stuck at this point not knowing whether there is a simple way to do this.
