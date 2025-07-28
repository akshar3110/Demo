import 'package:flutter/material.dart';



class RejectJob extends StatefulWidget {
  const RejectJob({super.key});

  @override
  State<RejectJob> createState() => _RejectJobState();
}

 class _RejectJobState extends State<RejectJob>{
   final TextEditingController _controller = TextEditingController();
   bool _showHint = true;

   @override
   void initState() {
     super.initState();
     _controller.addListener(() {
       setState(() {
         _showHint = _controller.text.trim().isEmpty;
       });
     });
   }

   @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      appBar: AppBar(
        backgroundColor: Color(0xFFF8F9FA),
        elevation: 0,
        automaticallyImplyLeading: false,
        toolbarHeight: 60,
        title: Row(
          children: [
            IconButton(
              icon: Icon(Icons.close, color: Colors.black, size: 14,),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(width: 8),
            Text(
              'Reject Job',
              style: TextStyle(
                color: Colors.black,
                fontFamily: 'Fredoka',
                fontSize: 16,
              ),
            ),
          ],
        ),
      ),
      body: Column(
        children: [
          Container(
            width: double.infinity,
            padding: EdgeInsets.all(20),
            alignment: Alignment.center,
            child: Text('Order ID #12345681',style: TextStyle(fontFamily: 'SansSerif',fontSize: 16,fontWeight: FontWeight.w600),),
          ),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 0,horizontal: 20),
            child: Stack(
              children: [
                TextField(
                  controller: _controller,
                  maxLines: 5,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 20),
                  ),
                  style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                ),
                if (_showHint)
                  Positioned(
                    top: 18,
                    left: 24,
                    child: IgnorePointer(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(text: 'Write Reason of Job Rejection ', style: TextStyle(color: Colors.grey, fontFamily: 'Fredoka', fontSize: 14)),
                            TextSpan(text: '*', style: TextStyle(color: Colors.red, fontFamily: 'Fredoka', fontSize: 14)),
                          ],
                        ),
                      ),
                    ),
                  ),
              ],
            ),
          ),
        ],
      ),
      bottomNavigationBar: Padding(
        padding: EdgeInsets.all(30),
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE7B958),
              shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(30),),
            ),
            onPressed: () {
              // Navigator.push(context, MaterialPageRoute(builder: (context) => JobHistory(),));
            },
            child: Text('Continue', style: TextStyle(fontSize: 18, fontFamily: 'Fredoka', color: Colors.white, fontWeight: FontWeight.bold,),),
          ),
        ),
      ),
    );
  }
 }