import 'package:find_job/jobdetail.dart';
import 'package:flutter/material.dart';

void main() => runApp(MyApp());

class MyApp extends StatelessWidget {
  // This widget is the root of your application.
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
        debugShowCheckedModeBanner: false,
        theme: ThemeData(
          primarySwatch: Colors.blue,
        ),
        home: HomePage());
  }
}

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  @override
  Widget build(BuildContext context) {
    initJob();
    return Scaffold(
      appBar: AppBar(
        leading: Icon(Icons.menu, color: Colors.white),
        actions: <Widget>[
          Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: <Widget>[
              Icon(
                Icons.check_circle,
                color: Colors.white,
              ),
              Text(
                "İşlerim",
                style: TextStyle(color: Colors.white),
              ),
            ],
          ),
          Padding(
            padding: const EdgeInsets.only(right: 8.0, left: 8),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                Icon(
                  Icons.person,
                  color: Colors.white,
                ),
                Text(
                  "Profilim",
                  style: TextStyle(color: Colors.white),
                ),
              ],
            ),
          ),
        ],
        backgroundColor: Colors.red,
        title: Center(
            child: Text(
          "İşin Olsun",
          style: TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
              fontSize: 18,
              letterSpacing: 2),
        )),
      ),
      body: Body(),
      backgroundColor: Colors.white70,
    );
  }
}

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int selectedTabIndex = 0;
  List<Job> jobList = subMenuList[0].jobList;

  topMenu() => Container(
        decoration: BoxDecoration(
          color: Colors.white,
        ),
        child: Padding(
          padding: const EdgeInsets.all(8.0),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.access_time,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "En yeni",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.navigation,
                    color: Colors.red,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Yakınımda",
                      style: TextStyle(color: Colors.red),
                    ),
                  ),
                ],
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: <Widget>[
                  Icon(
                    Icons.home,
                    color: Colors.grey,
                  ),
                  Padding(
                    padding: const EdgeInsets.only(left: 8.0),
                    child: Text(
                      "Evime yakın",
                      style: TextStyle(color: Colors.grey),
                    ),
                  ),
                ],
              )
            ],
          ),
        ),
      );

  subMenu() => Container(
        width: MediaQuery.of(context).size.width,
        height: 70,
        child: ListView.builder(
            itemCount: subMenuList.length,
            scrollDirection: Axis.horizontal,
            itemBuilder: (contex, index) {
              return Container(
                height: 75,
                width: 75,
                child: GestureDetector(
                  onTap: () {
                    setState(() {
                      selectedTabIndex = index;
                      jobList = subMenuList[index].jobList;
                    });
                  },
                  child: Card(
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: <Widget>[
                        Icon(
                          subMenuList[index].icon,
                          color: Colors.red,
                        ),
                        Text(
                          subMenuList[index].name,
                          style: TextStyle(
                              color: index == selectedTabIndex
                                  ? Colors.red
                                  : Colors.black38,
                              fontSize: 10),
                        )
                      ],
                    ),
                  ),
                ),
              );
            }),
      );

  jobs() => Container(
        width: MediaQuery.of(context).size.width,
        height: MediaQuery.of(context).size.height * 0.77,
        child: ListView.builder(
            itemCount: jobList.length,
            scrollDirection: Axis.vertical,
            itemBuilder: (contex, index) {
              return JobItem(
                job: jobList[index],
              );
            }),
      );

  @override
  Widget build(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        topMenu(),
        subMenu(),
        jobs(),
      ],
    );
  }
}

class JobItem extends StatelessWidget {
  Job job;

  JobItem({this.job});

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: (){
        Navigator.push(context, MaterialPageRoute(builder:  (context) => JobDetail(job)));
      },
      child: Padding(
        padding: const EdgeInsets.only(left: 4, right: 4),
        child: Card(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceEvenly,
            children: <Widget>[
              Row(
                mainAxisAlignment: MainAxisAlignment.start,
                children: <Widget>[
                  Padding(
                    padding: const EdgeInsets.all(8.0),
                    child: Card(
                      child: Image.network(
                        job.img,
                        fit: BoxFit.fill,
                        height: 100,
                        width: 150,
                      ),
                    ),
                  ),
                  Container(
                    height: 100,
                    child: Column(
                      children: <Widget>[
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(
                            job.name,
                            style: TextStyle(
                                color: Colors.black,
                                fontWeight: FontWeight.bold),
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.all(8.0),
                          child: Text(job.owner,
                              style: TextStyle(
                                color: Colors.black,
                              )),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
              Container(
                width: MediaQuery.of(context).size.width,
                child: Padding(
                  padding: const EdgeInsets.all(8.0),
                  child: Text(job.description),
                ),
              ),
              Container(
                height: 1,
                width: MediaQuery.of(context).size.width,
                decoration: BoxDecoration(color: Colors.black12),
              ),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: <Widget>[
                    Row(
                      children: <Widget>[
                        Icon(
                          Icons.navigation,
                          color: Colors.black38,
                          size: 16,
                        ),
                        Text(
                          "${job.distance} /km",
                          style: TextStyle(color: Colors.black38, fontSize: 10),
                        ),
                        Icon(
                          Icons.location_on,
                          color: Colors.black38,
                          size: 16,
                        ),
                        Text(job.location,
                            style:
                                TextStyle(color: Colors.black38, fontSize: 10))
                      ],
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: <Widget>[
                        Icon(
                          Icons.access_time,
                          color: Colors.black38,
                          size: 16,
                        ),
                        Text(
                          " 15+ gün",
                          style: TextStyle(color: Colors.black38, fontSize: 10),
                        ),
                      ],
                    )
                  ],
                ),
              )
            ],
          ),
        ),
      ),
    );
  }
}

class SubMenu {
  String name;
  IconData icon;
  List<Job> jobList;

  SubMenu(this.name, this.icon, {this.jobList});

  @override
  String toString() {
    return 'SubMenu{name: $name, icon: $icon, jobList: $jobList}';
  }
}

class Job {
  String name;
  String description;
  String owner;
  double distance;
  String location;
  int time;
  String img;

  @override
  String toString() {
    return 'Job{name: $name, description: $description, owner: $owner, distance: $distance, location: $location, time: $time, img: $img}';
  }

  Job(
      {this.name,
      this.description,
      this.owner,
      this.img,
      this.distance,
      this.location,
      this.time});
}

List<SubMenu> subMenuList = [
  new SubMenu("Tüm ilanlar", Icons.list),
  new SubMenu("Garson", Icons.fastfood, jobList: [
    new Job(
        name: "Garson",
        owner: "AKINCIZADE",
        description:
            "tecrübeli diksiyonu düzgün garson arkadaş ihtiyacımız vardır",
        img:
            "https://upload-isinolsun-com.mncdn.com/company/job/2019/8/18/77546320190818115611817.jpg",
        distance: 0.12,
        time: 9,
        location: "İlkadım/Samsun"),
    new Job(
        name: "Garson",
        owner: "Cardak Fast Food",
        description: "Fast Food restaurant çalışmak üzere garson",
        img:
            "https://fastly.4sqi.net/img/general/600x600/58555239_lsorYrvYgUoYgl9LxR9ONMpgXmIB7Jeotm3CcaP1JD4.jpg",
        distance: 0.9,
        time: 15,
        location: "Zafer/Samsun"),
    new Job(
        name: "Garson",
        owner: "Okay Döner",
        description: "Yeni açılan iş yerimizde bizimle çalışmak ister misiniz?",
        img: "https://pbs.twimg.com/media/EAt4I45WkAAHKNn.jpg",
        distance: 0.24,
        time: 15,
        location: "19 Mayıs/Samsun"),
    new Job(
        name: "Garson",
        owner: "Simit Street",
        description:
            "Deneyimli Bay-Bayan Garson Elemanı Güler yüzlü iletişim ve ikna kabiliyeti yüksek",
        img:
            "https://lh3.googleusercontent.com/p/AF1QipP691WLIA0q_wRP0iZgczTeb3VU9BrSqzIz6Rd2=w600-k",
        distance: 0.34,
        time: 15,
        location: "İlkadım/Samsun"),
    new Job(
        name: "Garson",
        owner: "Ekrem Coşkun Döner",
        description:
            "İşletmemizde garson-komi pozisyonunda çalışmak üzere çalışma arkadaşları arıyoruz",
        img: "http://www.gazeteanadolu.com/files/uploads/020bffc4fc.jpg",
        distance: 0.37,
        time: 15,
        location: "İlkadım/Samsun"),
  ]),
  new SubMenu("Sekreter", Icons.phone_in_talk, jobList: [
    new Job(
        name: "Sekreter",
        owner: "Arda kombi servisi",
        description: "Çağrı aktivasyon müşteri takibi yapabilecek",
        img:
            "http://bedelteknik.com/wp-content/uploads/2019/08/bedelteknikpetektemizleme-1024x576.jpg",
        distance: 0.09,
        time: 15,
        location: "19 Mayıs/Samsun"),
    new Job(
        name: "Sekreter",
        owner: "Arda",
        description:
            "Çalışma düzenine ayak uydurabilen çalışma arkadaşı aranıyor.",
        img:
            "http://bedelteknik.com/wp-content/uploads/2019/08/bedelteknikpetektemizleme-1024x576.jpg",
        distance: 0.15,
        time: 15,
        location: "İlkadım/Samsun"),
    new Job(
        name: "Sekreter",
        owner: "Water grup",
        description:
            "Merhaba orduda faliyet gösteren warlılife su arıtma sistemleri",
        img:
            "https://yt3.ggpht.com/a-/AAuE7mDni-H9bVDzVvuwYos9K6fp8Cka7eja-HCYkQ=s800-mo-c-c0xffffffff-rj-k-no",
        distance: 0.59,
        time: 15,
        location: "Samsun"),
    new Job(
        name: "Sekreter",
        owner: "Moonlight",
        description:
            "Şirketimizde çalışmak üzere sekreter elemanı alınacaktır.",
        img:
            "https://www.samsundabul.com/wp-content/uploads/cache/images/2019/08/moonlight-logo/moonlight-logo-2549384325.jpg",
        distance: 0.59,
        time: 15,
        location: "Samsun"),
    new Job(
        name: "Sekreter",
        owner: "Moonlight",
        description:
            "Şirketimizde çalışmak üzere bakımlı giyimine özen gösteren konuşma diksiyonu iyi olan eleman alınacaktır.",
        img:
            "https://www.samsundabul.com/wp-content/uploads/cache/images/2019/08/moonlight-logo/moonlight-logo-2549384325.jpg",
        distance: 0.59,
        time: 15,
        location: "Samsun"),
  ]),
  new SubMenu("Temizlik", Icons.clear_all, jobList: []),
  new SubMenu("Aşçı", Icons.local_dining, jobList: []),
  new SubMenu("Tüm ilanlar", Icons.home, jobList: []),
  new SubMenu("Tüm ilanlar", Icons.home, jobList: []),
  new SubMenu("Tüm ilanlar", Icons.home, jobList: []),
  new SubMenu("Tüm ilanlar", Icons.home, jobList: []),
  new SubMenu("Tüm ilanlar", Icons.home, jobList: []),
  new SubMenu("Tüm ilanlar", Icons.home, jobList: []),
  new SubMenu("Tüm ilanlar", Icons.home, jobList: []),
  new SubMenu("Tüm ilanlar", Icons.home, jobList: []),
];

initJob() {
  List<Job> tmp = [];
  for (int i = 1; i < subMenuList.length; i++) {
    for (var job in subMenuList[i].jobList) tmp.add(job);
  }
  subMenuList[0].jobList = tmp;

  for (int i = 0; i < subMenuList.length; i++) {
    subMenuList[i].jobList.sort((a, b) {
      return a.distance.compareTo(b.distance);
    });
  }
}
