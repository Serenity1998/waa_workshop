import 'package:flutter/material.dart';

class NewsDetails extends StatelessWidget {
  const NewsDetails({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(
        slivers: [
          SliverAppBar(
            bottom: PreferredSize(
                preferredSize: Size.fromHeight(100),
                child: Padding(
                  padding: EdgeInsets.all(50),
                  child: Container(
                    width: double.maxFinite,
                    // color: Colors.white,
                    child: Text(
                      'A Sea of Colors',
                      style: TextStyle(
                          fontWeight: FontWeight.w400,
                          fontSize: 30,
                          color: Colors.white),
                    ),
                  ),
                )),
            // pinned: true,
            expandedHeight: 300,
            flexibleSpace: FlexibleSpaceBar(
              background: Image.network(
                'https://img.freepik.com/premium-photo/astronaut-outer-open-space-planet-earth-stars-provide-background-erforming-space-planet-earth-sunrise-sunset-our-home-iss-elements-this-image-furnished-by-nasa_150455-16829.jpg?w=2000',
                width: double.maxFinite,
                fit: BoxFit.cover,
              ),
            ),
          ),
          SliverToBoxAdapter(
            child: Container(
              decoration: BoxDecoration(
                // color: Colors.white,
                borderRadius: BorderRadius.only(
                  topLeft: Radius.circular(20.0),
                  topRight: Radius.circular(20.0),
                ),
              ),
              child: Padding(
                padding: EdgeInsets.symmetric(horizontal: 24, vertical: 12),
                child: Text(
                  'Studies have identified numerous risk factors for dementia, some of which can be modified (changed; like drinking or smoking) and some of which cannot be modified (like genetic factors). It is estimated that 40% of dementias could be prevented or at least delayed [1]. Among the modifiable risk factors identified for dementia, level of education is one of the most important—that is why it is important to go to school! Education improves cognitive reserveThe idea that people build up a reserve of thinking skills over the course of their lives. This protects them from losing thinking skills as they age or get sick., which is your brain’s ability to come up with new ideas and find different ways to do things, and thus seems to offer some protection against dementia [2]. However, education is not the only way to increase or maintain cognitive reserve. Continuous learning and participation in brain-stimulating activities, both at home and at work, also increases cognitive reserve and fights against cognitive declineCognitive decline in older adults means that a person’s thinking, memory, concentration, and other brain functions are not as good as they should be for their age., which is the age-induced decline of cognitive functions (see Figure 1).',
                  style: TextStyle(fontWeight: FontWeight.w400, fontSize: 16),
                ),
              ),
            ),
          )
        ],
        // child: Container(
        //   child: Text('testing'),
        // ),
      ),
    );
  }
}
