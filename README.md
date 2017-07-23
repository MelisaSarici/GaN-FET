# GaN-FET
GaN Modelling-Analysis Research League
(New additions appearing on top)

24.7.17
Hocam şimdi ben bu modeli düzenledim ancak aklıma takılan çok önemli bir husus var ki bayağıdır içinden çıkamadım. Şöyle ki ben MOSFETi modellerken switching kısmı için bir matematiksel block yaratıyorum ve bu block içerisinde if blockları ile çalışıyor ve doğal olarak Id akımının bağlı olduğu constant Vt ve Kn ile değişken olan Vgs ve Vds değerlerini input olarak alıyor. Bu değerleri de doğal olarak fiziksel olan dünyadan yani elekriksel devreden alması gerekiyor.

Ben de switch diye adlandırdığım matematik
sel bloğu voltaj sensörleri ile bağlamayı amaçladım ancak switch diye düşündüğümüz arkadaş aslında fiziksel dünyada gerçekten drain ve source u birbirine bağlamakta. Ben bu şekilde herhangi bir connection yapamadığım için doğru bir model olamıyor ve sensörden aldığım bilgi de aslında arada asla bağlantı yokmuş gibi oluyor. (iki tarafa da  Id outputunu PS converter ile bağlamaya çalıştım ama olmadı.)
  Öbür yandan basit bir switch ile modellemek istesem de şu sorunla karşılaşıyorum:iki farklı akım denklemi ve 3 farklı condition mevcut. Ben bu voltage dependent currentı library de var olan elemala yapamıyorum çünkü bu akım dependency i linear alıyor ve hazır kodu değişemiyorum. Ayriyeten bir fonksiyon bloğu yazmak istesem bu bloğa birden çok değişken alınca problem oluyor.

  Nasıl bir çözüm önerirsiniz? Ben son modelimden memnunum ve onu fiziksel olan devreyle nasıl entegre edebilirm bunu merak ediyorum. Değişiklik  yaptığım M.stv modeline bakabilirseniz sevinirim.



18.7.17
Using "MOSFET model.png" I tried to create another model,
Copying from th e source I work from:(Power electronics component matlab.pdf doc added)
"Assumptions and Limitations
The MOSFET block implements a macro model of the real MOSFET device. It does not take into account
either the geometry of the device or the complex physical processes [1].
Depending on the value of the inductance Lon, the MOSFET is modeled either as a current source (Lon >
0) or as a variable topology circuit (Lon = 0). The MOSFET block cannot be connected in series with an
inductor, a current source, or an open circuit, unless its snubber circuit is in use. See Improving
Simulation Performance for more details on this topic.
Use the Powergui block to specify either continuous simulation or discretization of your electrical circuit
containing MOSFET blocks. When using a continuous model, the ode23tb solver with a relative tolerance
of 1e-4 is recommended for best accuracy and simulation speed.
The inductance Lon is forced to 0 if you choose to discretize your circuit."




2.7.17
I configured the model a little bit. Here I had the problem of configuration solver which I intend to solve later on. I used the parameters provided in the datasheet of GaN-FET site of which we will be using in our upcoming experiments.
3.7.17
Solver configuration is solved, there are two scopes two obtain both input voltage and output current. The output is wrong but will be worked upon later.
4.7.17
I added a function block for Id representation however there might be a wrong representation in the blocks. I will try to use another way for Id.
18.7.17

I tried to improve the other model as well but with little improvement. Somehow, I think, I am making a mistake connecting the elements and putting the function. Also this simulink function thing is a bit complicated since I need an if statement for the model. There are various types of function writing one of which is an "if block function writing". It did not work out well since it requires too many connections and making the model look complicated. Hence I am looking for something simple which will handle everything in one simple MATLAB function with if statements inside. However, I tried this and it looks not possibe this way. I am a little bit stuck at this point not knowing whether there is a simple way to do this.
