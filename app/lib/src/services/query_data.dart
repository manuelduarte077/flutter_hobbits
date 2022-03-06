class QueryData {
  String insertPost() {
    return '''
      mutation CreatePost(\$comment: String!, \$userId: String!) {
        CreatePost(comment: \$comment, userId: \$userId){
          id
          comment
        }   
      }
    ''';
  }

  static insertUser() {
    return ''' 
      mutation CreateUserMutation(\$name: String!, \$age: Int!, \$profession: String!){
        createUser(name: \$name, age: \$age, profession: \$profession) {
            id
            name
            profession
            age
        }
      }
    ''';
  }

  String insertHobby() {
    return '''
      mutation CreateHobby(\$title: String!, \$description: String!, \$userId: String!) {
        CreateHobby(title: \$title, description: \$description, userId: \$userId){
          id
          title
        }   
      }
    ''';
  }

  static String updateUser() {
    return '''
      mutation UpdateUser(\$id: String!, \$name: String!, \$profession: String!, \$age: Int!) {
        UpdateUser(id: \$id, name: \$name, profession: \$profession, age: \$age){
          name
        }   
      }
    ''';
  }

  final String query = '''
    query {
      users{
        name
        id
        profession
        age
        posts{
          id
          comment
          userId
        }
          id
          title
          description
          userId
        }
      }
    
    } 
 
  ''';

  String removeUser() {
    return '''
      mutation RemoveUser(\$id: String!) {
      RemoveUser(id: \$id){
          name
        }   
      }
    ''';
  }

  String removePosts() {
    return ''' 
      mutation RemovePosts(\$ids: [String]) {
        RemovePosts(ids: \$ids){
          
        }   
      }
    ''';
  }

  String removeHobbies() {
    return '''
      mutation RemoveHobbies(\$ids: [String]) {
        RemoveHobbies(ids: \$ids){
        
        }   
      }
     ''';
  }
}
