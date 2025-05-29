@extends('layouts.app')

@section('content')
    <div class="container">
        <h1>{{ $message }}</h1>

        <form method="POST" action="/example">
            @csrf
            <label for="name">Name:</label>
            <input type="text" name="name" id="name">
            <button type="submit">Submit</button>
        </form>
    </div>
@endsection
