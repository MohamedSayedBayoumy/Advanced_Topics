import 'package:flutter/material.dart';

class CheckPortraitOrLandscapePage extends StatefulWidget {
  const CheckPortraitOrLandscapePage({super.key});

  @override
  State<CheckPortraitOrLandscapePage> createState() =>
      _CheckPortraitOrLandscapePageState();
}

class _CheckPortraitOrLandscapePageState
    extends State<CheckPortraitOrLandscapePage> {
  @override
  Widget build(BuildContext context) {
    final orientation = MediaQuery.of(context).orientation;
    final media = MediaQuery.sizeOf(context);
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Theme.of(context).colorScheme.inversePrimary,
        title: const Text("Check Portrait Or Landscape"),
      ),
      body: ListView(
        shrinkWrap: true,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(horizontal: 20),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                const Text(
                  'You have pushed the button this many times:',
                ),
                const SizedBox(height: 15),
                if (orientation == Orientation.portrait) ...[
                  ListView.builder(
                    shrinkWrap: true,
                    physics: const NeverScrollableScrollPhysics(),
                    itemCount: 15,
                    itemBuilder: (context, index) => Padding(
                      padding: const EdgeInsets.only(bottom: 10),
                      child: Container(
                        width: media.width,
                        height: media.height * .14,
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(10),
                            border: Border.all(color: Colors.black)),
                        alignment: Alignment.center,
                        child: const Text("data"),
                      ),
                    ),
                  ),
                ] else ...[
                  SizedBox(
                      width: media.width,
                      height: media.height,
                      child: GridView.builder(
                          gridDelegate:
                              const SliverGridDelegateWithFixedCrossAxisCount(
                                  crossAxisCount: 2),
                          itemBuilder: (context, index) => Padding(
                                padding: const EdgeInsets.only(bottom: 10),
                                child: Container(
                                  width: media.width,
                                  height: media.height * .14,
                                  decoration: BoxDecoration(
                                      borderRadius: BorderRadius.circular(10),
                                      border: Border.all(color: Colors.black)),
                                  alignment: Alignment.center,
                                  child: const Text("data"),
                                ),
                              ))),
                ]
              ],
            ),
          ),
        ],
      ),
    );
  }
}
