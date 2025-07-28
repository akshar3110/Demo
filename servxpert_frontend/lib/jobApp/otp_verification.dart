import 'package:flutter/material.dart';


class OtpVerificationStartWorking extends StatefulWidget {
  final Map<String, dynamic> jobItem;
  final VoidCallback onStartWork;
  const OtpVerificationStartWorking({super.key, required this.jobItem, required this.onStartWork,});

  @override
  State<OtpVerificationStartWorking> createState() => _OtpVerificationStartWorkingState();
}

class _OtpVerificationStartWorkingState extends State<OtpVerificationStartWorking>{
  @override
  Widget build(BuildContext context) {
    final job = widget.jobItem;
    final orderId = job['order_id'] ?? 'N/A';
    final service = job['service'] ?? 'N/A';
    final address = job['address'] ?? 'N/A';
    final status = job['status'] ?? 'N/A';
    final amount = job['amount'] ?? 'N/A';
    final date = job['date']?.toString() ?? 'N/A';

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
              'Start Work #$orderId',
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
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Column(
              spacing: 15,
              children: [
                Text('Enter OTP',style: TextStyle(fontFamily: 'MPlus',fontWeight: FontWeight.bold,fontSize: 18),),
                Text('Please enter the 4-digit code',style: TextStyle(fontFamily: 'MPlus',fontWeight: FontWeight.bold,fontSize: 12,color: Colors.grey),),
                Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                          border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          fillColor: Color(0xFFF7F7F7),
                          filled: true,
                          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                          counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                Text('Resend',style: TextStyle(fontFamily: 'MPlus',fontWeight: FontWeight.bold,color: Color(0xFFBB9648),fontSize: 12),)

              ],
            ),
          )
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
              widget.onStartWork();
            },
            child: Text('Start Working', style: TextStyle(fontSize: 18, fontFamily: 'Fredoka', color: Colors.white, fontWeight: FontWeight.bold,),),
          ),
        ),
      ),
    );
  }
}


class OtpVerificationCompleteWork extends StatefulWidget {
  const OtpVerificationCompleteWork({super.key});

  @override
  State<OtpVerificationCompleteWork> createState() => _OtpVerificationCompleteWorkState();
}

class _OtpVerificationCompleteWorkState extends State<OtpVerificationCompleteWork>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            margin: EdgeInsets.only(bottom: 5),
            width: double.infinity,
            height: 160,
            decoration: BoxDecoration(
              color: Color(0xFF506C5C),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.person_2_outlined,color: Colors.black,))
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Current Location', style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Fredoka')),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.white, size: 14),
                        Text('Ahmedabad, Gujarat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12, fontFamily: 'Fredoka')),
                      ],
                    )
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(onPressed: (){},icon: Icon(Icons.notifications_none_outlined,color: Colors.black,)),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: Column(
              spacing: 15,
              children: [
                Text('Enter OTP',style: TextStyle(fontFamily: 'MPlus',fontWeight: FontWeight.bold,fontSize: 18),),
                Text('Please enter the 4-digit code',style: TextStyle(fontFamily: 'MPlus',fontWeight: FontWeight.bold,fontSize: 12,color: Colors.grey),),
                Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                Text('Resend',style: TextStyle(fontFamily: 'MPlus',fontWeight: FontWeight.bold,color: Color(0xFFBB9648),fontSize: 12),)

              ],
            ),
          )
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


class OtpVerificationCloseJob extends StatefulWidget {
  final Map<String, dynamic> jobItem;

  /// ✅ Add this!
  final VoidCallback onCloseJob;

  const OtpVerificationCloseJob({
    super.key,
    required this.jobItem,
    required this.onCloseJob,
  });

  @override
  State<OtpVerificationCloseJob> createState() => _OtpVerificationCloseJobState();
}

class _OtpVerificationCloseJobState extends State<OtpVerificationCloseJob> {
  final TextEditingController _reasonController = TextEditingController();
  final TextEditingController _otp1 = TextEditingController();
  final TextEditingController _otp2 = TextEditingController();
  final TextEditingController _otp3 = TextEditingController();
  final TextEditingController _otp4 = TextEditingController();

  final FocusNode _focus1 = FocusNode();
  final FocusNode _focus2 = FocusNode();
  final FocusNode _focus3 = FocusNode();
  final FocusNode _focus4 = FocusNode();

  bool _showHint = true;

  @override
  void initState() {
    super.initState();
    _reasonController.addListener(() {
      setState(() {
        _showHint = _reasonController.text.trim().isEmpty;
      });
    });
  }

  @override
  void dispose() {
    _reasonController.dispose();
    _otp1.dispose();
    _otp2.dispose();
    _otp3.dispose();
    _otp4.dispose();
    _focus1.dispose();
    _focus2.dispose();
    _focus3.dispose();
    _focus4.dispose();
    super.dispose();
  }

  void _handleCloseJob() {
    final reason = _reasonController.text.trim();
    final otp1 = _otp1.text.trim();
    final otp2 = _otp2.text.trim();
    final otp3 = _otp3.text.trim();
    final otp4 = _otp4.text.trim();

    if (reason.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter a reason to close the job'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    if (otp1.isEmpty || otp2.isEmpty || otp3.isEmpty || otp4.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        SnackBar(
          content: Text('Please enter the complete 4-digit OTP'),
          backgroundColor: Colors.red,
        ),
      );
      return;
    }

    // ✅ Call parent's callback
    widget.onCloseJob();
  }

  Widget _buildOtpBox({
    required TextEditingController controller,
    required FocusNode focusNode,
    required FocusNode? nextFocus,
  }) {
    return SizedBox(
      width: 50,
      child: TextField(
        controller: controller,
        focusNode: focusNode,
        textAlign: TextAlign.center,
        decoration: InputDecoration(
          border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
          enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
          fillColor: Color(0xFFF7F7F7),
          filled: true,
          focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
          counterText: '',
        ),
        maxLength: 1,
        keyboardType: TextInputType.number,
        onChanged: (value) {
          if (value.isNotEmpty && nextFocus != null) {
            FocusScope.of(context).requestFocus(nextFocus);
          }
        },
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final job = widget.jobItem;
    final orderId = job['order_id'] ?? 'N/A';

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
              icon: Icon(Icons.close, color: Colors.black, size: 14),
              onPressed: () => Navigator.pop(context),
            ),
            SizedBox(width: 8),
            Text(
              'Close Job #$orderId',
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
            padding: EdgeInsets.only(top: 20),
            alignment: Alignment.center,
            child: Column(
              children: [
                Text(
                  'Enter OTP',
                  style: TextStyle(
                    fontFamily: 'MPlus',
                    fontWeight: FontWeight.bold,
                    fontSize: 18,
                  ),
                ),
                Text(
                  'Please enter the 4-digit code',
                  style: TextStyle(
                    fontFamily: 'MPlus',
                    fontWeight: FontWeight.bold,
                    fontSize: 12,
                    color: Colors.grey,
                  ),
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    _buildOtpBox(controller: _otp1, focusNode: _focus1, nextFocus: _focus2),
                    SizedBox(width: 10),
                    _buildOtpBox(controller: _otp2, focusNode: _focus2, nextFocus: _focus3),
                    SizedBox(width: 10),
                    _buildOtpBox(controller: _otp3, focusNode: _focus3, nextFocus: _focus4),
                    SizedBox(width: 10),
                    _buildOtpBox(controller: _otp4, focusNode: _focus4, nextFocus: null),
                  ],
                ),
                Text(
                  'Resend',
                  style: TextStyle(
                    fontFamily: 'MPlus',
                    fontWeight: FontWeight.bold,
                    color: Color(0xFFBB9648),
                    fontSize: 12,
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 30),
          Container(
            width: double.infinity,
            margin: EdgeInsets.symmetric(vertical: 5, horizontal: 20),
            child: Stack(
              children: [
                TextField(
                  controller: _reasonController,
                  maxLines: 4,
                  decoration: InputDecoration(
                    enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                    focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                    contentPadding: EdgeInsets.symmetric(vertical: 16, horizontal: 15),
                  ),
                  style: TextStyle(fontFamily: 'SansSerif', fontSize: 14),
                ),
                if (_showHint)
                  Positioned(
                    top: 18,
                    left: 15,
                    child: IgnorePointer(
                      child: RichText(
                        text: TextSpan(
                          children: [
                            TextSpan(
                              text: 'Write Reason For Close Job ',
                              style: TextStyle(
                                color: Colors.grey,
                                fontFamily: 'Fredoka',
                                fontSize: 14,
                              ),
                            ),
                            TextSpan(
                              text: '*',
                              style: TextStyle(
                                color: Colors.red,
                                fontFamily: 'Fredoka',
                                fontSize: 14,
                              ),
                            ),
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
        padding: EdgeInsets.symmetric(vertical: 5, horizontal: 30),
        child: SizedBox(
          width: double.infinity,
          height: 45,
          child: ElevatedButton(
            style: ElevatedButton.styleFrom(
              backgroundColor: Color(0xFFE7B958),
              shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(30),
              ),
            ),
            onPressed: _handleCloseJob,
            child: Text(
              'Close Job',
              style: TextStyle(
                fontSize: 18,
                fontFamily: 'Fredoka',
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
        ),
      ),
    );
  }
}


class OtpVerificationSolveComplaint extends StatefulWidget {
  const OtpVerificationSolveComplaint({super.key});

  @override
  State<OtpVerificationSolveComplaint> createState() => _OtpVerificationSolveComplaintState();
}

class _OtpVerificationSolveComplaintState extends State<OtpVerificationSolveComplaint>{
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Color(0xFFF8F9FA),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.only(top: 50, left: 20, right: 20),
            margin: EdgeInsets.only(bottom: 5),
            width: double.infinity,
            height: 130,
            decoration: BoxDecoration(color: Color(0xFF506C5C)),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                CircleAvatar(
                    backgroundColor: Colors.white,
                    child: IconButton(onPressed: (){}, icon: Icon(Icons.person_2_outlined,color: Colors.black,))
                ),
                Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text('Current Location', style: TextStyle(color: Colors.white, fontSize: 12, fontFamily: 'Fredoka')),
                    Row(
                      children: [
                        Icon(Icons.location_on_outlined, color: Colors.white, size: 14),
                        Text('Ahmedabad, Gujarat', style: TextStyle(color: Colors.white, fontWeight: FontWeight.w500, fontSize: 12, fontFamily: 'Fredoka')),
                      ],
                    )
                  ],
                ),
                CircleAvatar(
                  backgroundColor: Colors.white,
                  child: IconButton(onPressed: (){},icon: Icon(Icons.notifications_none_outlined,color: Colors.black,)),
                ),
              ],
            ),
          ),
          Container(
            width: double.infinity,
            padding: EdgeInsets.only(top: 30),
            alignment: Alignment.center,
            child: Column(
              spacing: 15,
              children: [
                Text('Enter OTP',style: TextStyle(fontFamily: 'MPlus',fontWeight: FontWeight.bold,fontSize: 18),),
                Text('Please enter the 4-digit code',style: TextStyle(fontFamily: 'MPlus',fontWeight: FontWeight.bold,fontSize: 12,color: Colors.grey),),
                Row(
                  spacing: 15,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),

                    SizedBox(
                      width: 50,
                      child: TextField(
                        textAlign: TextAlign.center,
                        decoration: InputDecoration(
                            border: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            enabledBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            fillColor: Color(0xFFF7F7F7),
                            filled: true,
                            focusedBorder: OutlineInputBorder(borderSide: BorderSide(color: Color(0xFFCDD4DA))),
                            counterText: ''
                        ),
                        maxLength: 1,
                        keyboardType: TextInputType.number,
                      ),
                    ),
                  ],
                ),

                Text('Resend',style: TextStyle(fontFamily: 'MPlus',fontWeight: FontWeight.bold,color: Color(0xFFBB9648),fontSize: 12),)

              ],
            ),
          )
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
              // Navigator.push(context, MaterialPageRoute(builder: (context) => Complaints(),));
            },
            child: Text('Continue', style: TextStyle(fontSize: 18, fontFamily: 'Fredoka', color: Colors.white, fontWeight: FontWeight.bold,),),
          ),
        ),
      ),
    );
  }
}
