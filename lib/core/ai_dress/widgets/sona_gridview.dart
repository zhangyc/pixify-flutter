import 'package:flutter/material.dart';
import 'package:sona/core/ai_dress/bean/sd_template.dart';

import '../dislogs.dart';

enum DataLoadStatus {
  loading,
  loaded,
  failed,
}

class SonaGridView extends StatefulWidget {
  final Future<List<SdTemplate>> Function() fetchData;

  SonaGridView({required this.fetchData});

  @override
  _MyGridViewState createState() => _MyGridViewState();
}

class _MyGridViewState extends State<SonaGridView> {
  late Future<List<SdTemplate>> Function() _futureData;

  @override
  void initState() {
    super.initState();
    _futureData = widget.fetchData;
  }

  @override
  Widget build(BuildContext context) {
    return FutureBuilder<List<SdTemplate>>(
      future: _futureData.call(),
      builder: (context, AsyncSnapshot<List<SdTemplate>> snapshot) {
        if (snapshot.connectionState == ConnectionState.waiting) {
          return Center(child: CircularProgressIndicator());
        } else if (snapshot.hasError) {
          return Center(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text('Error loading data'),
                SizedBox(height: 10),
                ElevatedButton(
                  onPressed: () {
                    setState(() {
                      _futureData = widget.fetchData;
                    });
                  },
                  child: Text('Retry'),
                ),
              ],
            ),
          );
        } else if (snapshot.hasData) {
          return GridView.builder(
            itemCount: snapshot.data?.length??0, // 子项数量
            gridDelegate: SliverGridDelegateWithFixedCrossAxisCount(
              crossAxisCount: 2, // 每行显示的子项数量
              mainAxisSpacing: 10.0, // 主轴方向（垂直方向）的间距
              crossAxisSpacing: 10.0, // 交叉轴方向（水平方向）的间距
            ),
            itemBuilder: (BuildContext context, int index) {
              SdTemplate template=snapshot.data![index];
              return GestureDetector(
                child: Container(
                  color: Colors.blueGrey,
                  alignment: Alignment.center,
                  child: Text(
                    'Item $index',
                    style: TextStyle(color: Colors.white),
                  ),
                ),
                onTap: (){
                  showSelectPhoto(context,template);
                },
              );
            },
          );
        } else {
          return Container(); // Placeholder for empty state
        }
      },
    );
  }
}
