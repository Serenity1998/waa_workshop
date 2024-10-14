import 'package:get/get.dart';

class NewsController extends GetxController {
  final currentStatus = ''.obs;
  final newsValues = <dynamic>[
    {'id': '0', 'text': 'All'},
    {'id': '1', 'text': 'Health'},
    {'id': '2', 'text': 'Mind'},
  ].obs;
  RxList<String> filters = ["Спорт", "Боловсрол", "Технологи"].obs;
  RxInt selectedIndex = 0.obs;
  final news = <dynamic>[
    {
      'id': '0',
      'topic': 'Health',
      'description': 'A Sea of Colors',
      'introduction':
          'What is the first color that comes to mind when you think of the ocean? Blue, right? Pictures of the planet from space show that what we call Earth is mostly a blue ocean (if we knew this earlier, we may have named it Ocean rather than Earth!). ',
      'detail':
          'Although we always associate the oceans to the blue color, other colors such as green, brown, and even yellowish can be observed. The diverse color palette presented in the oceans and other water bodies is due to the presence of colored components that interact with the light in the water. Those components are, for instance, (1) the water itself, which gives a blue color to the oceans; (2) very tiny plants that can give a greenish color to the water; (3) dissolved compounds that turns the water into a brown-yellowish color; and (4) sediments, which gives a milky color to the oceans. In this article, we explain how those components change the color of the water and how marine scientists use satellites to capture those changes from space and convert them into information for their research.',
      'createdAt': 'November 13',
      'imageUrl':
          'https://www.frontiersin.org/files/Articles/818636/frym-10-818636-HTML/image_m/main.jpg',
      'reporter': 'Marina'
    },
    {
      'id': '11',
      'topic': 'Mind',
      'description':
          'Brain Training Games: An Effective Tool in the Fight Against Dementia',
      'introduction':
          'As life expectancy—the average age people live to—increases, it poses many challenges to health care systems. The World Health Organization (WHO) estimates that there will',
      'detail':
          'Studies have identified numerous risk factors for dementia, some of which can be modified (changed; like drinking or smoking) and some of which cannot be modified (like genetic factors). It is estimated that 40% of dementias could be prevented or at least delayed [1]. Among the modifiable risk factors identified for dementia, level of education is one of the most important—that is why it is important to go to school! Education improves cognitive reserveThe idea that people build up a reserve of thinking skills over the course of their lives. This protects them from losing thinking skills as they age or get sick., which is your brain’s ability to come up with new ideas and find different ways to do things, and thus seems to offer some protection against dementia [2]. However, education is not the only way to increase or maintain cognitive reserve. Continuous learning and participation in brain-stimulating activities, both at home and at work, also increases cognitive reserve and fights against cognitive declineCognitive decline in older adults means that a person’s thinking, memory, concentration, and other brain functions are not as good as they should be for their age., which is the age-induced decline of cognitive functions (see Figure 1).',
      'createdAt': 'November 17',
      'imageUrl':
          'https://www.frontiersin.org/files/Articles/904425/frym-10-904425-HTML/image_m/main.jpg',
      'reporter': 'Bruno'
    },
    {
      'id': '1',
      'topic': 'Health',
      'description': 'The Weird and Wonderful World of Worms',
      'introduction':
          'When we think about worms, we usually think about the earthworms we see in the garden or wiggling on the sidewalk after it rains. Or we might think about parasitic worms that live inside other animals, or leeches that feed on blood. While these are the worms we see most often, worms first evolved in the ocean and most species of worms still live there today.',
      'detail':
          'Animals with long, skinny bodies are often called “worms,” but there are many kinds of worms—even in the ocean. Annelids (segmented worms) include garden earthworms, but their ocean relatives come in many colors, shapes, and sizes. Some are so small that they live between grains of sand, while others can be longer than a human and eat fish! Marine worms are essential to the ocean food web, as both predators and prey. They help create homes for plants and animals by burrowing and building tubes in ocean sediments. Scientists are still discovering new worm species, and there are still many mysteries about how worms eat, why they live in the places they do, and what roles they play in ocean ecosystems. Worms are a fascinating and important part of ocean communities.',
      'createdAt': 'November 14',
      'imageUrl':
          'https://www.frontiersin.org/files/Articles/902248/frym-10-902248-HTML/image_m/main.jpg',
      'reporter': 'Marina'
    },
    {
      'id': '12',
      'topic': 'Mind',
      'description':
          'How a Component of Marijuana Can Be Used to Treat Epilepsy',
      'introduction':
          'n the past, plants were the only medical resources available to people. Although plants were used a lot, sometimes they had dangerous effects.',
      'detail':
          'The human body is an amazing machine, and the nervous system is an important part of it. The nervous system, which contains the brain, spinal cord, and nerves, controls functions that are both under our control, such as thinking and moving, and those that are controlled without thinking about them, like heartbeat and bowel movements .Imagine that your brain is a school, made up of a team of teachers and students: the neurons. Neurons are an important cell type within the nervous system, and they pass and receive information all the time, controlling many body functions. Teachers and students must talk to each other to exchange information. This process takes place in classrooms. These are the synapses: areas where two neurons meet to communicate. The words spoken are neurotransmittersSignaling molecules produced by neurons. Through them it is possible to send information to other cells., chemical signals responsible for conversations between neurons. But sometimes everyone tries to communicate at the same time, and the activities in the school go wrong. This happens in the brains of people with epilepsyA neurological disorder that affects the activity of neurons in the brain and causes seizures., the most common disease of the nervous system [1].',
      'createdAt': 'November 18',
      'imageUrl':
          'https://www.frontiersin.org/files/Articles/817939/frym-10-817939-HTML/image_m/main.jpg',
      'reporter': 'Marina'
    },
    {
      'id': '2',
      'topic': 'Health',
      'description':
          'Mangrove Madness: What Are Mangroves and Why Do We Care About Them?',
      'introduction':
          'In tropical environments all over the world, mangrove communities consist of about 70 different species of trees, palms, shrubs, and ferns that live along the Earth’s coastlines in the intertidal zoneThe area of the marine coastline that is either flooded by water at high tide or exposed to air at low tide., which is where the ocean meets the land [1]. Often, they are found in estuariesThe place where freshwater flows into the ocean.—places where freshwater rivers flow into the ocean. Freshwater that arrives in estuaries often carries soil sediments, nutrients, and pesticides.',
      'detail':
          'It is not normal for trees to grow in water, much less saltwater—but mangrove trees do it. So how do they do this? First, mangrove trees must deal with living in a lot of water, and then they need to figure out what to do with all the salt. Over time, mangroves have developed unique root systems that allow them to live in flooded habitats. Their roots are different from those of ordinary plants and have names like pneumatophores (pronounced new-mat-uh-fours), knees, aerial roots, and prop roots (Figures 1A,B). These special roots stick out of the water, which helps the trees breathe through special pores, called lenticlesSpecial pores in woody plant stems or roots that allow gas exchange., that let in oxygen (Figure 1A). Other structures move the oxygen to the parts of the trees that are underwater. This unique root system prevents the trees from drowning.',
      'createdAt': 'November 15',
      'imageUrl':
          'https://www.frontiersin.org/files/Articles/716954/frym-10-716954-HTML/image_m/main.jpg',
      'reporter': 'Marina'
    },
  ].obs;
  void changeTab(String topic) async {
    currentStatus.value = topic;
  }
}
