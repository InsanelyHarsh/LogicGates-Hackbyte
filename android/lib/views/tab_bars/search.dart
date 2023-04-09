import 'package:flutter/material.dart';

class Search extends StatelessWidget {
  //List<
  const Search({super.key});
  @override
  Widget build(BuildContext context) {
    TextEditingController cont = TextEditingController();
    return SafeArea(
      child: Container(
        padding: const EdgeInsets.symmetric(vertical: 10, horizontal: 10),
        child: Column(
          children: [
            Container(
              padding: const EdgeInsets.only(left: 5),
              decoration: BoxDecoration(
                  color: Colors.grey[300],
                  borderRadius: BorderRadius.circular(12)),
              child: TextField(
                controller: cont,
                decoration: InputDecoration(
                  hintText: 'Search',
                  hintStyle: TextStyle(
                    color: Colors.grey[600],
                  ),
                  border: InputBorder.none,
                  icon: Icon(
                    Icons.search,
                    color: Colors.grey[500],
                  ),
                ),
              ),
            ),
            const SizedBox(height: 50,),
            Icon(
              Icons.search,
              size: 60,
              color: Colors.grey[500],
            ),
            Text(
              'Find Your SpotLight',
              style: TextStyle(
                color: Colors.grey[500],
                fontSize: 30,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
